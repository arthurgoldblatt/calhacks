//
//  ViewController.swift
//  Fire
//
//  Created by Anthony Bajoua on 10/27/19.
//  Copyright © 2019 booligans. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let ref = Database.database().reference()
        ref.child("yeah").setValue("lol")
        
        // Do any additional setup after loading the view.
    }


}

