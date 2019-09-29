//
//  ViewController.swift
//  EventProfiler
//
//  Created by Ripan Halder on 4/25/19.
//  Copyright © 2019 Ripan Halder. All rights reserved.
//

import UIKit

// For Networking
import Alamofire

//For handing JSON data
import SwiftyJSON

// For GPS
import CoreLocation

import Firebase

class HomeViewController: UIViewController, CLLocationManagerDelegate {

    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID_WEATHER = "e72ca729af228beabd5d20e3b7749713"
    let TICKETMASTER_URL = "https://app.ticketmaster.com/discovery/v2/events.json"
    let apikey_TICKETMASTER = "fIRCn8mPeMioQxpu9GSvCmtHs3oNprD9"
    let BING_MAPS_URL = "http://dev.virtualearth.net/REST/v1/Locations/"
    let key_BingMaps = "AlkHgF-sCAG7gmAxDk1asU7xc_z2PpBY0UACtrnYn8CdLzMaO_E9tJIShG2PIFJr"
    
    //TODO: Declared instance variables here
    let locationManager = CLLocationManager()
    let climateModel = ClimateModel()
    let locationDataModel = LocationDataModel()
    let eventDataModel = EventDataModel()
    
    
    //Pre-linked IBOutlets
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var climateImage: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        //TODO:Set up the location manager here.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }

    //MARK: - Networking
    /***************************************************************/
    
    //Write the getWeatherData method here:
    func getWeatherData(url: String, parameters: [String: String]) {
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                
                print("Success! Got the weather data")
                let weatherJSON : JSON = JSON(response.result.value!)
                
                
                print(weatherJSON)
                
                self.updateWeatherData(json: weatherJSON)
                
            }
            else {
                print("Error \(String(describing: response.result.error))")
                self.cityLabel.text = "Connection Issues"
            }
        }
        
    }
    

    //MARK: - JSON Parsing
    /***************************************************************/
    
    //Write the updateWeatherData method here:
    
    
    func updateWeatherData(json : JSON) {
        
        if let tempResult = json["main"]["temp"].double {
        
            climateModel.temperature = Int(tempResult - 273.15)
            
            climateModel.city = json["name"].stringValue
            
            climateModel.condition = json["weather"][0]["id"].intValue
            
            climateModel.weatherIconName = climateModel.updateWeatherIcon(condition: climateModel.condition)
            
            updateUIWithWeatherData()
        }
        
        else {
                self.cityLabel.text = "Weather Unavailable"
            }
        }

    
    //MARK: - UI Updates
    /***************************************************************/
    
    
    //Write the updateUIWithWeatherData method here:
    
    func updateUIWithWeatherData() {
        
        cityLabel.text = climateModel.city
        temperatureLabel.text = "\(climateModel.temperature)°"
        climateImage.image = UIImage(named: climateModel.weatherIconName)
    }
    
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    //Write the didUpdateLocations method here:
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            
            self.locationManager.stopUpdatingLocation()
            
            print("longitude = \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)")
            
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            
            let params : [String : String] = ["lat" : latitude, "lon" : longitude, "appid" : APP_ID_WEATHER]
            
            getWeatherData(url: WEATHER_URL, parameters: params)
        }
    }
    
    //Write the didFailWithError method here:
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "Location Unavailable"
    }
 
    
}

