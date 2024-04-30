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
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.appName
        navigationItem.hidesBackButton = true
        
        tableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        
        loadMessages()

    }
    //MARK: - Loading messages from Fireabse
    func loadMessages(){

        db.collection(Constants.FStore.collectionName)
            .order(by: Constants.FStore.dateField)
            .addSnapshotListener{ snapshot, error in
                
            self.messages = []
            if let error = error{
                print(error)
            }else{
                if let snapshotDocuments = snapshot?.documents{
                    for doc in snapshotDocuments{
                        let data = doc.data()
                        if let messageSender = data[Constants.FStore.senderField] as? String, let messageBody = data[Constants.FStore.bodyField] as? String{
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            
                            self.messages.append(newMessage)
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                            self.messageTextfield.text = ""
                        }
                    }
                }
            }
        }
    }
    
    //MARK: - Sending message and saving on Firebase

    @IBAction func sendPressed(_ sender: UIButton) {
        
        if let messageBody = messageTextfield.text,let messageSender = Auth.auth().currentUser?.email{
            db.collection(Constants.FStore.collectionName).addDocument(data: [Constants.FStore.senderField: messageSender, Constants.FStore.bodyField: messageBody, Constants.FStore.dateField: Date().timeIntervalSince1970]) {(error) in
                if let error = error{
                    print("Erro ao salvar os dados no Firestore")
                }else{
                    
                    print("Dados salvos no firebase")
                }
            }
        }
    }
    //MARK: - quitin from the app, going back to the fisrt view
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

