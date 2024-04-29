//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    var db = Firestore.firestore()
    
    var messages: [Message] = [
        Message(sender: "gu@gmail.com", body: "Olá"),
        Message(sender: "gustavo@gmail.com", body: "E ai"),
        Message(sender: "let@gmail.com", body: "Beleza")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.appName
        navigationItem.hidesBackButton = true
        
        tableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)

    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
        if let messageBody = messageTextfield.text,let messageSender = Auth.auth().currentUser?.email{
            db.collection(Constants.FStore.collectionName).addDocument(data: [Constants.FStore.senderField: messageSender, Constants.FStore.bodyField: messageBody]) {(error) in
                if let error = error{
                    print("Erro ao salvar os dados no Firestore")
                }else{
                    
                    print("Dados salvos no firebase")
                }
            }
        }
        
        
        
    }
    
    @IBAction func sairPressed(_ sender: UIBarButtonItem) {
        do{
            try Auth.auth().signOut()
            
            navigationController?.popToRootViewController(animated: true)
        }catch let signOutError as NSError{
            print("Erro siging out")
        }
    }
    
}


extension ChatViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! MessageCell
        
        cell.labelMessage.text = messages[indexPath.row].body
 

        
        return cell
    }
}

