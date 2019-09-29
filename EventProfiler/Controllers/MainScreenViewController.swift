//
//  MainScreenViewController.swift
//  EventProfiler
//
//  Created by Ripan Halder on 4/26/19.
//  Copyright © 2019 Ripan Halder. All rights reserved.
//

import UIKit
// For Networking
import Alamofire

//For handing JSON data
import SwiftyJSON

// For GPS
import CoreLocation


//for Database
import FirebaseDatabase

import Firebase
class MainScreenViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var logoutNavBarButton: UIBarButtonItem!
    
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
    var eventDataModel = EventDataModel()
    var listOfEvents : [EventDataModel] = []
    var ref:DatabaseReference?
    var refHandle : DatabaseHandle?
    var genreId : String = ""
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var climateImage: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var eventsNearMe: UIButton!
    @IBOutlet weak var searchMyProfiledEvents: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //TODO:Set up the location manager here.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        ref = Database.database().reference()
        loadUser(key: Auth.auth().currentUser!.uid)
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
                
                
                //print(weatherJSON)
                
                self.updateWeatherData(json: weatherJSON)
                
            }
            else {
                print("Error \(String(describing: response.result.error))")
                self.cityLabel.text = "Connection Issues"
            }
        }
        
    }
    
    //The getTicketMasterData method :
    func getTicketMasterData(url: String, parameters: [String: String]) {
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                
                print("Success! Got the Ticket Master data")
                let ticketMasterJSON : JSON = JSON(response.result.value!)
                
                
                print(ticketMasterJSON)
                
                self.updateEventData(json: ticketMasterJSON)
                
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
            
            let paramsTicketMaster1 : [String : String] = ["city" : climateModel.city, "apikey" : apikey_TICKETMASTER, "startDateTime" : "2019-04-26T14:00:00Z", "sort" : "date,name,asc", "genreId" : genreId]
            
            getTicketMasterData(url: TICKETMASTER_URL, parameters: paramsTicketMaster1)
            
            updateUIWithWeatherData()
        }
            
        else {
            self.cityLabel.text = "Weather Unavailable"
        }
    }
    
    func updateEventData(json : JSON) {

        for (key, value) in json["_embedded"]["events"] {
            if let eventName = value["name"].string {
                eventDataModel = EventDataModel()
                eventDataModel.city = climateModel.city
                eventDataModel.venue = value["_embedded"]["venues"][0]["name"].stringValue + ", " +
                    value["_embedded"]["venues"][0]["address"]["line1"].stringValue
                
                eventDataModel.eventName = eventName
                
                eventDataModel.startDate = value["dates"]["start"]["localDate"].stringValue
                
                
                eventDataModel.image = value["images"][0]["url"].stringValue
                
                eventDataModel.maxPrice = value["priceRanges"][0]["max"].intValue
                
                eventDataModel.minPrice = value["priceRanges"][0]["min"].intValue
                
                //            updateUIWithWeatherData()
            
            listOfEvents.append(eventDataModel)
            }
                
            else {
//                self.cityLabel.text = "Weather Unavailable"
            }
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
    
    func loadUser(key:String){
        ref!.child("users").child(key).observe(.value, with: {(snapshot) in
            let value = snapshot.value as? NSDictionary
            let snapshotValue = snapshot.value as! [String:String]
            print("Snapshot Value -----------------------------")
            print(snapshotValue)
            for (_,c) in snapshotValue.enumerated(){
                self.genreId += c.value
                self.genreId += ","
            }
            self.genreId = String(self.genreId.dropLast())
        }) {(error) in
            print("error while reading database")}
    }
    
    

    
    @IBAction func eventsNearMeButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "showEventsTableView", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEventsTableView"{
            let eventsTableVC = segue.destination as! EventsViewController
            eventsTableVC.listOfEvents = listOfEvents
        }
    }
    
    
    @IBAction func logoutNavBarButtonPressed(_ sender: UIBarButtonItem) {
        do{
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        }catch{
            print("Error Signing out!")
        }
    }
    
    @IBAction func searchMyProfiledEventsButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "mainScreenToProfiledSearch", sender: self)
    }
    
}
