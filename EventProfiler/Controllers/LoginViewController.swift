//
//  LoginViewController.swift
//  EventProfiler
//
//  Created by Ripan Halder on 4/25/19.
//  Copyright © 2019 Ripan Halder. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func loginButtonPressed(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil{
                print(error!)
            }else{
                print("Login Successful")
                self.performSegue(withIdentifier: "goToMainScreenFromLogin", sender: self)
            }
        }
    }

}
