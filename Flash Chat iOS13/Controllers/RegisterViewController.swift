//
//  RegisterViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    


    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBAction func registerPressed(_ sender: UIButton) {
        //cadastrando usuário
        if let email = emailTextfield.text,  let senha = passwordTextfield.text{
            Auth.auth().createUser(withEmail: email, password: senha) { authResult, error in
                if let error = error{
                    print(error.localizedDescription)
                    
                }else{
                    
                    self.performSegue(withIdentifier: "registerToChat", sender: self)
                }
            }
        }
       

    }
    
}
