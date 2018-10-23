//
//  MessagesTVCell.swift
//  VK-c
//
//  Created by Timur on 14.08.2018.
//  Copyright © 2018 Timur. All rights reserved.
//

import UIKit

class ConversationsTVCell: UITableViewCell {
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameFriend: UILabel!
    @IBOutlet weak var dateLastMessages: UILabel!
    @IBOutlet weak var lastMessages: UILabel!
    
    var conversation: ConversationModelForCell? {
        didSet {
            avatarImage.image = nil
            lastMessages.text = conversation?.lastMessageText
            nameFriend.text = conversation?.friendName
            dateLastMessages.text = conversation?.date
            guard let url = conversation?.friendsAvatar else { return }
            
            DispatchQueue.main.async { [weak self] in
                guard let s = self else { return }
                ApiWrapper.loadPhoto(imgURL: url, imgView: s.avatarImage)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImage.layer.cornerRadius = avatarImage.frame.height/2.0 //* 0.1
        avatarImage.layer.masksToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
