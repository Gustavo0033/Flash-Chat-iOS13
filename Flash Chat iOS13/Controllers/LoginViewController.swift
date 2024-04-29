//
//  LoginViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//
import FirebaseAuth
import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    

    @IBAction func loginPressed(_ sender: UIButton) {
        
        if let email = emailTextfield.text, let senha = passwordTextfield.text{
            Auth.auth().signIn(withEmail: email, password: senha) {authResutl, error in
                if let error = error{
                    print(error)
                }else{
                    self.performSegue(withIdentifier: "loginToChat", sender: self)
                }
            }
        }
    }
    
}
