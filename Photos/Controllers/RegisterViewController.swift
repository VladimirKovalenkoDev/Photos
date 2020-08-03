//
//  RegisterViewController.swift
//  Photos
//
//  Created by Владимир Коваленко on 03.08.2020.
//  Copyright © 2020 Vladimir Kovalenko. All rights reserved.
//

import UIKit
import Firebase
class RegisterViewController: UIViewController {

    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        if let email = emailTextfield.text, let password = passwordTextfield.text{
               Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                   if let e = error {
                       print(e.localizedDescription)
                       self.title = "Register NOW!!!"
                   }else{
                       self.performSegue(withIdentifier: "FromRegisterToChat" , sender: self)
                   }
               }
               }
    }
    

}
