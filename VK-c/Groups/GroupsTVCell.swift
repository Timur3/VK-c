//
//  GroupsTVCell.swift
//  VK-c
//
//  Created by Timur on 29.07.2018.
//  Copyright © 2018 Timur. All rights reserved.
//

import UIKit

class GroupsTVCell: UITableViewCell {

    @IBOutlet private weak var avatarGroup: UIImageView!
    @IBOutlet private weak var nameGroup: UILabel!
    @IBOutlet private weak var noteGroup: UILabel!
    
    var group: Group? {
        didSet {
            nameGroup.text = group?.name
            DispatchQueue.main.asyncAfter(deadline: .now() + 10.0, execute: {
                //ApiWrapper.getMembersGroup(groupId: (self.group?.id)!, label: self.noteGroup)
                self.noteGroup.text = "10 подписчиков"
            })
            guard let url = group?.photo100 else { return }
            DispatchQueue.main.async { [weak self] in
                guard let s = self else { return }
                ApiWrapper.loadPhoto(imgURL: url, imgView: s.avatarGroup)
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarGroup.layer.cornerRadius = avatarGroup.frame.height/2.0 //* 0.1
        avatarGroup.layer.masksToBounds = true
        //avatarGroup.contentMode = UIViewContentMode.scaleAspectFill
        //avatarGroup.clipsToBounds = true
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
