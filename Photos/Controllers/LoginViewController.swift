//
//  LoginViewController.swift
//  Photos
//
//  Created by Владимир Коваленко on 03.08.2020.
//  Copyright © 2020 Vladimir Kovalenko. All rights reserved.
//

import UIKit
import Firebase
class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!

    @IBAction func loginButtonPressed(_ sender: UIButton) {
        if let email = emailTextfield.text, let password = passwordTextfield.text {
        Auth.auth().signIn(withEmail: email, password: password) {  authResult, error in
            if let er = error {
                print(er)
                self.title = "Wrong"
            }else{
                self.performSegue(withIdentifier: "fromLogin", sender: self)
            }
        }
        }
    }
    

}
