//
//  EventsViewController.swift
//  EventProfiler
//
//  Created by Ripan Halder on 4/26/19.
//  Copyright © 2019 Ripan Halder. All rights reserved.
//

import UIKit


import Firebase

class EventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let TICKETMASTER_URL = "https://app.ticketmaster.com/discovery/v2/events.json"
    let apikey_TICKETMASTER = "fIRCn8mPeMioQxpu9GSvCmtHs3oNprD9"
    
    @IBOutlet weak var logoutButton: UIBarButtonItem!
    @IBOutlet weak var eventsTableView: UITableView!
    
    var listOfEvents : [EventDataModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        eventsTableView.delegate = self
        eventsTableView.dataSource = self
        
        //Register our custom cell xib file
        eventsTableView.register(UINib(nibName: "EventsCustomTableViewCell", bundle: nil) , forCellReuseIdentifier: "eventsCustomTableViewCell")
        
        configureTableView()
        
        eventsTableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        eventsTableView.reloadData()
    }
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventsCustomTableViewCell", for: indexPath) as! EventsCustomTableViewCell
        
        cell.eventNameLabel.text = listOfEvents[indexPath.row].eventName
        cell.eventVenueLabel.text = listOfEvents[indexPath.row].venue
        cell.eventStartDateLabel.text = "Starts on " + listOfEvents[indexPath.row].startDate
        cell.eventPriceRangeLabel.text = "Min: $" + String(listOfEvents[indexPath.row].minPrice) + " & Max: $" + String(listOfEvents[indexPath.row].maxPrice)
        let remoteUrl : NSURL? = NSURL(string: listOfEvents[indexPath.row].image)
        do{
        try cell.eventImage.image = UIImage(data: NSData(contentsOf: remoteUrl! as URL) as Data)
        }catch{
            print("Error binding image")
            return cell
        }
        
        return cell
    }
    
    //TODO: Declare configureTableView here:
    
    func configureTableView() {
        eventsTableView.rowHeight = UITableView.automaticDimension
        eventsTableView.estimatedRowHeight = 120.0
    }

    @IBAction func logoutButtonPressed(_ sender: UIBarButtonItem) {
        
        do{
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        }catch{
            print("Error Signing out!")
        }
    }
}
