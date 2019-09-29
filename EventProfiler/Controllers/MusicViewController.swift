//
//  MusicViewController.swift
//  EventProfiler
//
//  Created by Ripan Halder on 4/27/19.
//  Copyright © 2019 Ripan Halder. All rights reserved.
//


import UIKit
import Firebase
import FirebaseDatabase

class MusicViewController : UIViewController {
    
    //Database reference and its handlers
    var ref:DatabaseReference?
    var refHandle:DatabaseHandle = 0
    
    @IBOutlet weak var CountryButton : ToggleButton!
    @IBOutlet weak var ElectronicButton : ToggleButton!
    @IBOutlet weak var MetalButton : ToggleButton!
    @IBOutlet weak var PopButton : ToggleButton!
    @IBOutlet weak var RAndBButton : ToggleButton!
    @IBOutlet weak var RapButton : ToggleButton!
    @IBOutlet weak var RockButton : ToggleButton!
    
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
        if(CountryButton.isOn){
            let title = CountryButton.title(for: .normal)
            ref!.child("users").child(key).child(title!).setValue("KnvZfZ7vAv6")
        }
        if(ElectronicButton.isOn){
            let title = ElectronicButton.title(for: .normal)
            ref!.child("users").child(key).child(title!).setValue("KnvZfZ7vAvF")
        }
        if(MetalButton.isOn){
            let title = MetalButton.title(for: .normal)
            ref!.child("users").child(key).child(title!).setValue("KnvZfZ7vAvt")
        }
        if(PopButton.isOn){
            let title = PopButton.title(for: .normal)
            ref!.child("users").child(key).child(title!).setValue( "KnvZfZ7vAev")
        }
        if(RAndBButton.isOn){
            let title = RAndBButton.title(for: .normal)
            ref!.child("users").child(key).child(title!).setValue("KnvZfZ7vAee")
        }
        if(RapButton.isOn){
            let title = RapButton.title(for: .normal)
            ref!.child("users").child(key).child(title!).setValue("KnvZfZ7vAv1")
        }
        if(RockButton.isOn){
            let title = RockButton.title(for: .normal)
            ref!.child("users").child(key).child(title!).setValue("KnvZfZ7vAeA")
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        saveUserPreferencesForFilms(key : Auth.auth().currentUser!.uid)
        performSegue(withIdentifier: "musicToMainScreen", sender: self)
    }
    
    
}


