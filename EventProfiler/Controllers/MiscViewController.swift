//
//  MiscViewController.swift
//  EventProfiler
//
//  Created by Ripan Halder on 4/27/19.
//  Copyright © 2019 Ripan Halder. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class MiscViewController : UIViewController {
    
    //Database reference and its handlers
    var ref:DatabaseReference?
    var refHandle:DatabaseHandle = 0
    
    @IBOutlet weak var ComedyButton : ToggleButton!
    @IBOutlet weak var FairsAndFestivalsButton : ToggleButton!
    @IBOutlet weak var FamilyButton : ToggleButton!
    @IBOutlet weak var FoodAndDrinkButton : ToggleButton!
    @IBOutlet weak var HealthButton : ToggleButton!
    @IBOutlet weak var HobbyButton : ToggleButton!
    @IBOutlet weak var LectureButton : ToggleButton!
    @IBOutlet weak var MultimediaButton : ToggleButton!
    
    override func viewDidLoad() {
        
        //Create Database reference
        self.ref = Database.database().reference()
    }
    
    func retrieveUser(){
        let userDB = ref?.child("users")
        userDB?.observe(.childAdded, with: { (snapshot) in
            let snapshotValue = snapshot.value as! NSDictionary
            print(snapshotValue)
        } )
    }
    
    func saveUserPreferencesForFilms(key: String) {
        if(ComedyButton.isOn){
            let title = ComedyButton.title(for: .normal)
            ref!.child("users").child(key).child(title!).setValue("KnvZfZ7vAA1")
        }
        if(FairsAndFestivalsButton.isOn){
            let title = FairsAndFestivalsButton.title(for: .normal)
            ref!.child("users").child(key).child(title!).setValue("KnvZfZ7vAeE")
        }
        if(FamilyButton.isOn){
            let title = FamilyButton.title(for: .normal)
            ref!.child("users").child(key).child(title!).setValue("KnvZfZ7vA1n")
        }
        if(FoodAndDrinkButton.isOn){
            let title = FoodAndDrinkButton.title(for: .normal)
            ref!.child("users").child(key).child(title!).setValue("KnvZfZ7vAAI")
        }
        if(HealthButton.isOn){
            let title = HealthButton.title(for: .normal)
            ref!.child("users").child(key).child(title!).setValue("KnvZfZ7vAAl")
        }
        if(HobbyButton.isOn){
            let title = HobbyButton.title(for: .normal)
            ref!.child("users").child(key).child(title!).setValue( "KnvZfZ7vAAJ")
        }
        if(LectureButton.isOn){
            let title = LectureButton.title(for: .normal)
            ref!.child("users").child(key).child(title!).setValue("KnvZfZ7vAJe")
        }
        if(MultimediaButton.isOn){
            let title = MultimediaButton.title(for: .normal)
            ref!.child("users").child(key).child(title!).setValue("KnvZfZ7vAAF")
        }
        
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        saveUserPreferencesForFilms(key : Auth.auth().currentUser!.uid)
        performSegue(withIdentifier: "miscToMusic", sender: self)
    }
    
    
}


