//
//  LoginViewController.swift
//  Honest
//
//  Created by Arthur Goldblatt on 10/26/19.
//  Copyright © 2019 Arthur Goldblatt. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextFields()
        // Do any additional setup after loading the view.
        
    }
    
    
    @IBAction func submit(_ sender: Any) {
        let user = String(username.text!)
        let pass = String(password.text!)
        
        if validLogin(username: user, password: pass) {
            self.performSegue(withIdentifier: "successLoginSegue", sender: self)
        } else {
        }
    }
    
    func validLogin(username: String, password: String) -> Bool {
        if username == "arthur" && password == "123" {
            return true
        } else {
            return false
        }
    }
    
    
    func configureTextFields() {
        username.delegate = self
        password.delegate = self
    }
    
}




extension LoginViewController : UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true

    }
}

