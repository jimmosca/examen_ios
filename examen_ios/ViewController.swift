//
//  ViewController.swift
//  examen_ios
//
//  Created by Jaime Casado Aparicio on 26/2/20.
//  Copyright © 2020 Jaime Casado Aparicio. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class ViewController: UIViewController, GIDSignInUIDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.uiDelegate = self
        GIDSignIn.sharedInstance().signIn()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

