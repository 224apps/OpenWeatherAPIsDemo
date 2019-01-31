//
//  ViewController.swift
//  OpenWeatherAPIsDemo
//
//  Created by Abdoulaye Diallo on 1/31/19.
//  Copyright © 2019 224Apps. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
     let locationManager = CLLocationManager()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Comform to the location manager delegates.
         locationManager.delegate = self
         locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
         locationManager.startUpdatingLocation()
    }
}

//MARK: - Location Manager Delegate Methods.
extension ViewController: CLLocationManagerDelegate {
    
    //Tells the delegate that new location data is available.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         let latitude = locations.last?.coordinate.latitude
         let longitude = locations.last?.coordinate.longitude
        print( "\(String(describing: latitude)), \(String(describing: longitude))")
    }
    
}

