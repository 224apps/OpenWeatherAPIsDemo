//
//  ChangeCityViewController.swift
//  OpenWeatherAPIsDemo
//
//  Created by Abdoulaye Diallo on 1/31/19.
//  Copyright © 2019 224Apps. All rights reserved.
//

import UIKit


//PROTOCOL: - Change City protocols.
protocol ChangeCityViewDelegate {
    func userEnterNewCityName(city: String)
}

//CLASS: - ChangeCityViewController
class ChangeCityViewController: UIViewController {
    
    var delegate: ChangeCityViewDelegate?
    
    @IBOutlet weak var changeCityTextField: UITextField!
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func getWeatherPressed(_  sender: AnyObject){
        let cityName = changeCityTextField.text!
        delegate?.userEnterNewCityName(city: cityName)
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        
    }
}
