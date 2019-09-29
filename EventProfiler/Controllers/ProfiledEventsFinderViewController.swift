//
//  ProfiledEventsFinderViewController.swift
//  EventProfiler
//
//  Created by Ripan Halder on 4/27/19.
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

class ProfiledEventsFinderViewController: UIViewController {

    let TICKETMASTER_URL = "https://app.ticketmaster.com/discovery/v2/events.json"
    let apikey_TICKETMASTER = "fIRCn8mPeMioQxpu9GSvCmtHs3oNprD9"
    
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    
    var eventDataModel = EventDataModel()
    var listOfEvents : [EventDataModel] = []
    var ref:DatabaseReference?
    var refHandle : DatabaseHandle?
    var genreId : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startDatePicker.setValue(UIColor.white, forKey: "textColor")
        endDatePicker.setValue(UIColor.white, forKey: "textColor")
        searchButton.isEnabled = false
        okButton.isEnabled = true
        searchButton.isHidden = true
        okButton.isHidden = false
        cityTextField.isEnabled = true
        startDatePicker.isEnabled = true
        endDatePicker.isEnabled = true
        
        ref = Database.database().reference()
        loadUser(key: Auth.auth().currentUser!.uid)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        searchButton.isEnabled = false
        okButton.isEnabled = true
        searchButton.isHidden = true
        okButton.isHidden = false
        cityTextField.isEnabled = true
        startDatePicker.isEnabled = true
        endDatePicker.isEnabled = true
        listOfEvents = []
    }
    
    func loadUser(key:String){
        ref!.child("users").child(key).observe(.value, with: {(snapshot) in
            _ = snapshot.value as? NSDictionary
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
            }
        }
        
    }
    
    func updateEventData(json : JSON) {
        
        for (key, value) in json["_embedded"]["events"] {
            if let eventName = value["name"].string {
                eventDataModel = EventDataModel()
                eventDataModel.city = cityTextField.text!
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
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "profiledSearchToTableView"{
            let eventsTableVC = segue.destination as! EventsViewController
            eventsTableVC.listOfEvents = self.listOfEvents
        }
    }
    
    @IBAction func okButtonPressed(_ sender: UIButton) {
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd"
        
        let startDate = formatter.string(from: startDatePicker.date)+"T14:00:00Z"
        let endDate = formatter.string(from: endDatePicker.date)+"T14:00:00Z"
        
        let paramsTicketMaster1 : [String : String] = ["city" : cityTextField.text!, "apikey" : apikey_TICKETMASTER, "startDateTime" : startDate, "endDateTime" : endDate, "sort" : "date,name,asc", "genreId" : genreId]
        
        getTicketMasterData(url: TICKETMASTER_URL, parameters: paramsTicketMaster1)
        
        searchButton.isEnabled = true
        okButton.isEnabled = false
        searchButton.isHidden = false
        okButton.isHidden = true
        cityTextField.isEnabled = false
        startDatePicker.isEnabled = false
        endDatePicker.isEnabled = false
        
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "profiledSearchToTableView", sender: self)
    }
    
}
