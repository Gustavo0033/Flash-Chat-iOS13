//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by Gustavo Mendonca on 29/04/24.
//  Copyright © 2024 Angela Yu. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var labelMessage: UILabel!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var leftImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //para a mensagem caber dentro da view e se ajustar conforme o tamanho da mensagem
        messageView.layer.cornerRadius = messageView.frame.size.height / 5
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
