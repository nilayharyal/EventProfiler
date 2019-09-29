//
//  FimViewController.swift
//  EventProfiler
//
//  Created by Ripan Halder on 4/27/19.
//  Copyright © 2019 Ripan Halder. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class FilmViewController : UIViewController {
    
    //Database reference and its handlers
    var ref:DatabaseReference?
    var refHandle:DatabaseHandle = 0
    
    @IBOutlet weak var ActionButton : ToggleButton!
    @IBOutlet weak var AnimationButton : ToggleButton!
    @IBOutlet weak var ComedyButton: ToggleButton!
   @IBOutlet weak var DocumentaryButton: ToggleButton!
    @IBOutlet weak var DramaButton: ToggleButton!
    @IBOutlet weak var FamilyButton : ToggleButton!
    @IBOutlet weak var ForeignButton: ToggleButton!
    @IBOutlet weak var HorrorButton: ToggleButton!
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
        if(ActionButton.isOn){
            let title = ActionButton.title(for: .normal)
            ref!.child("users").child(key).child(title!).setValue("KnvZfZ7vAke")
        }
        if(AnimationButton.isOn){
            let title = AnimationButton.title(for: .normal)
            ref!.child("users").child(key).child(title!).setValue("KnvZfZ7vAkd")
        }
        if(ComedyButton.isOn){
            let title = ComedyButton.title(for: .normal)
            ref!.child("users").child(key).child(title!).setValue("KnvZfZ7vAkA")
        }
        if(DocumentaryButton.isOn){
            let title = DocumentaryButton.title(for: .normal)
            ref!.child("users").child(key).child(title!).setValue("KnvZfZ7vAkk")
        }
        if(DramaButton.isOn){
            let title = DramaButton.title(for: .normal)
            ref!.child("users").child(key).child(title!).setValue("KnvZfZ7vAk6")
        }
        if(FamilyButton.isOn){
            let title = FamilyButton.title(for: .normal)
            ref!.child("users").child(key).child(title!).setValue("KnvZfZ7vAkF")
        }
        if(ForeignButton.isOn){
            let title = ForeignButton.title(for: .normal)
            ref!.child("users").child(key).child(title!).setValue( "KnvZfZ7vAk1")
        }
        if(HorrorButton.isOn){
            let title = HorrorButton.title(for: .normal)
            ref!.child("users").child(key).child(title!).setValue("KnvZfZ7vAJk")
        }
        
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        saveUserPreferencesForFilms(key : Auth.auth().currentUser!.uid)
        performSegue(withIdentifier: "fimToMisc", sender: self)
    }
    
    
}

