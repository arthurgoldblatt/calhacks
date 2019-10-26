//
//  ViewController.swift
//  Honest
//
//  Created by Arthur Goldblatt on 10/25/19.
//  Copyright © 2019 Arthur Goldblatt. All rights reserved.
//

import UIKit

class AdderViewController: UIViewController {
    
    
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var quant: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextFields()
        // Do any additional setup after loading the view.
        
    }
    
    
    @IBAction func submit(_ sender: Any) {
        guard let text = quant.text, let number = Int(text) else {
            
        }
    
    }
    
    
    func configureTextFields() {
        name.delegate = self
        quant.delegate = self
    }
    
    
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
}

extension AdderViewController : UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true

    }
}

