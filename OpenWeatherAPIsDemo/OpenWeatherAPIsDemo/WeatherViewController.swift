//
//  ViewController.swift
//  OpenWeatherAPIsDemo
//
//  Created by Abdoulaye Diallo on 1/31/19.
//  Copyright © 2019 224Apps. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON


class WeatherViewController: UIViewController {
    @IBOutlet weak var farenheight: UISwitch!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var cityName: UILabel!
    var weatherDataModel = WeatherDataModel()
    let locationManager = CLLocationManager()
    
    @IBAction func changeCity(_ sender: Any) {
        
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Comform to the location manager delegates.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    //MARK: - Networking methods.
    func getWeatherData(url:String, parameters: [String:String])  {
        
        Alamofire.request(Constants.WEATHER_URL, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                print("Success. Got the weather message")
                let weatherJSON =  JSON(response.result.value!)
                self.updateWeatherData(json: weatherJSON)
                print( weatherJSON)
            } else {
                print("Error : \(String(describing: response.result.error))")
                
            }
        }
    }
    
    
    
    func updateWeatherData(json: JSON)  {
        if let temp = json["main"]["temp"].double {
            weatherDataModel.temperature = Int(temp - 273.15)
            weatherDataModel.city = json["name"].stringValue
            weatherDataModel.condition = json["weather"][0]["id"].intValue
            weatherDataModel.weatherIconName = weatherDataModel.updateWeatherConditions(condition: weatherDataModel.condition)
            updateUIWithData()
        } else {
            cityName.text = " Weather Unavailable."
        }
    }
    func updateUIWithData()  {
         cityName.text = weatherDataModel.city
         temperature.text = "\(weatherDataModel.temperature)"
         weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.ChangeCitySegue {
            let destinationVC =  segue.destination as! ChangeCityViewController
            destinationVC.delegate = self
        }
    }
}

//MARK: - Location Manager Delegate Methods.
extension WeatherViewController: CLLocationManagerDelegate {
    
    //Tells the delegate that new location data is available.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy  > 0 {
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
        }
        
        let latitude = String(location.coordinate.latitude)
        let longitude = String(location.coordinate.longitude)
        print( "\(String(describing: latitude)), \(String(describing: longitude))")
        let params = [ "lat": latitude, "lon": longitude, "appid": Constants.APP_ID ]
        getWeatherData(url: Constants.WEATHER_URL, parameters: params)
    }
}

//MARK: - Change City Delegate Methods.

extension WeatherViewController: ChangeCityViewDelegate {
    func userEnterNewCityName(city: String) {
        let params : [String:String] = ["q": city, "appid": Constants.APP_ID]
         getWeatherData(url: Constants.WEATHER_URL, parameters: params)
    }
    
}
