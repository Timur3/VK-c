//
//  FriendsTVCell.swift
//  VK-c
//
//  Created by Timur on 26.07.2018.
//  Copyright © 2018 Timur. All rights reserved.
//

import UIKit

class FriendsTVCell: UITableViewCell {
    
    @IBOutlet private weak var avatarPhoto: UIImageView!
    @IBOutlet private weak var avatarName: UILabel!
    
    var friend: User? {
        didSet {
            avatarPhoto.image = nil
            avatarName.text = friend?.getFullName()
            guard let url = friend?.photo400 else { return }
            
            //DispatchQueue.main.async { [weak self] in
              //  guard let s = self else { return }
                ApiWrapper.loadPhoto(imgURL: url, imgView: avatarPhoto)
            //}
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarPhoto.layer.cornerRadius = avatarPhoto.frame.height/2.0 // * 0.1
        avatarPhoto.layer.masksToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
