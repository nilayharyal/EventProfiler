//
//  SportsViewController.swift
//  EventProfiler
//
//  Created by Ripan Halder on 4/26/19.
//  Copyright © 2019 Ripan Halder. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class SportsViewController: UIViewController {

    // Database reference and its handler
    var ref:DatabaseReference?
    var refHandle : DatabaseHandle?
    @IBOutlet weak var baseballButton: ToggleButton!
    @IBOutlet weak var basketBallButton: ToggleButton!
    
    @IBOutlet weak var footballButton: ToggleButton!
    @IBOutlet weak var hockeyButton: ToggleButton!
    
    @IBOutlet weak var squashButton: ToggleButton!
    @IBOutlet weak var swimmingButton: ToggleButton!
    @IBOutlet weak var golfButton: ToggleButton!
    @IBOutlet weak var rugbyButton: ToggleButton!
    @IBOutlet weak var tennisButton: ToggleButton!
    
    @IBOutlet weak var saveSportsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.ref = Database.database().reference()
    }
    func saveUserPreferencesForSports(key: String) {
        if(baseballButton.isOn){
            let title = baseballButton.title(for: .normal)
            ref!.child("users").child(key).child(title!).setValue("KnvZfZ7v7na")
        }
        if(basketBallButton.isOn){
            let title = basketBallButton.title(for: .normal)
            ref!.child("users").child(key).child(title!).setValue("KnvZfZ7v7nJ")
        }
        if(footballButton.isOn){
            let title = footballButton.title(for: .normal)
            ref!.child("users").child(key).child(title!).setValue("KnvZfZ7vAe1")
        }
        if(hockeyButton.isOn){
            let title = hockeyButton.title(for: .normal)
            ref!.child("users").child(key).child(title!).setValue("KnvZfZ7v7nI")
        }
        if(squashButton.isOn){
            let title = squashButton.title(for: .normal)
            ref!.child("users").child(key).child(title!).setValue("KnvZfZ7v7nl")
        }
        if(swimmingButton.isOn){
            let title = swimmingButton.title(for: .normal)
            ref!.child("users").child(key).child(title!).setValue("KnvZfZ7v7lv")
        }
        if(golfButton.isOn){
            let title = golfButton.title(for: .normal)
            ref!.child("users").child(key).child(title!).setValue( "KnvZfZ7v7l1")
        }
        if(rugbyButton.isOn){
            let title = rugbyButton.title(for: .normal)
            ref!.child("users").child(key).child(title!).setValue( "KnvZfZ7v7l1")
        }
        if(golfButton.isOn){
            let title = golfButton.title(for: .normal)
            ref!.child("users").child(key).child(title!).setValue( "KnvZfZ7v7l1")
        }
        if(tennisButton.isOn){
            let title = tennisButton.title(for: .normal)
            ref!.child("users").child(key).child(title!).setValue( "KnvZfZ7v7l1")
        }
        
    }

    @IBAction func saveSportsToDB(_ sender: UIButton) {
        saveUserPreferencesForSports(key : Auth.auth().currentUser!.uid)
        performSegue(withIdentifier: "sportsToFilm", sender: self)
    }
    

}
