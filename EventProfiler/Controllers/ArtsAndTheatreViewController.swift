//
//  NewProfileViewController.swift
//  EventProfiler
//
//  Created by Ripan Halder on 4/26/19.
//  Copyright © 2019 Ripan Halder. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ArtsAndTheatreViewController: UIViewController {

    // Database reference and its handler
    var ref:DatabaseReference?
    var refHandle : DatabaseHandle?
    
    @IBOutlet weak var childrenTheatreButton: ToggleButton!
    
    @IBOutlet weak var classicalButton: ToggleButton!
    
    @IBOutlet weak var comedyButton: ToggleButton!
    
    @IBOutlet weak var danceButton: ToggleButton!
    @IBOutlet weak var fineArtButton: ToggleButton!
    
    @IBOutlet weak var magicAndIllussionButton: ToggleButton!
    
    @IBOutlet weak var theatreButton: ToggleButton!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
            //create database reference
            self.ref = Database.database().reference()
            //self.retrieveUser()

    }
    
    func retrieveUser(){
        let userDB = ref?.child("users")
        userDB?.observe(.childAdded, with: { (snapshot) in
            let snapshotValue = snapshot.value as! NSDictionary
            print(snapshotValue)
            
//            let value = snapshotValue.allValues as! [String:AnyObject]
//            print(value)
        })
    }
    
    func saveUserPreferencesForArtsAndTheatre(key: String) {
        if(childrenTheatreButton.isOn){
            let title = childrenTheatreButton.title(for: .normal)
            ref!.child("users").child(key).child(title!).setValue("KnvZfZ7v7na")
        }
        if(classicalButton.isOn){
            let title = classicalButton.title(for: .normal)
            ref!.child("users").child(key).child(title!).setValue("KnvZfZ7v7nJ")
        }
        if(comedyButton.isOn){
            let title = comedyButton.title(for: .normal)
            ref!.child("users").child(key).child(title!).setValue("KnvZfZ7vAe1")
        }
        if(danceButton.isOn){
            let title = danceButton.title(for: .normal)
            ref!.child("users").child(key).child(title!).setValue("KnvZfZ7v7nI")
        }
        if(fineArtButton.isOn){
            let title = fineArtButton.title(for: .normal)
            ref!.child("users").child(key).child(title!).setValue("KnvZfZ7v7nl")
        }
        if(magicAndIllussionButton.isOn){
            let title = magicAndIllussionButton.title(for: .normal)
            ref!.child("users").child(key).child(title!).setValue("KnvZfZ7v7lv")
        }
        if(theatreButton.isOn){
            let title = theatreButton.title(for: .normal)
            ref!.child("users").child(key).child(title!).setValue( "KnvZfZ7v7l1")
        }
        
    }
    
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        saveUserPreferencesForArtsAndTheatre(key : Auth.auth().currentUser!.uid)
        performSegue(withIdentifier: "artsToSports", sender: self)
    }
    
    
}
