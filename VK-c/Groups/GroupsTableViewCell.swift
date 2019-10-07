//
//  GroupsTVCell.swift
//  VK-c
//
//  Created by Timur on 29.07.2018.
//  Copyright © 2018 Timur. All rights reserved.
//

import UIKit

class GroupsTableViewCell: UITableViewCell {

    let api = ApiService()
    
    @IBOutlet private weak var avatarGroup: UIImageView!
    @IBOutlet private weak var nameGroup: UILabel!
    @IBOutlet private weak var noteGroup: UILabel!
    @IBOutlet private weak var activityGroup: UILabel!
    
    var group: Group? {
        didSet {
            
            nameGroup.text = group?.name
            activityGroup.text = group?.activity
            noteGroup.text = "\(group?.membersCount ?? 0) подписчика(-ов)"
            
            // Загружаем в отдельном потоке количество подписчиков
            DispatchQueue.main.asyncAfter(deadline: .now() + 10.0, execute: {
                //ApiWrapper.getMembersGroup(groupId: (self.group?.id)!, label: self.noteGroup)
                //self.noteGroup.text = "Подписчиков: 10"
            })
            guard let url = group?.photo100 else { return }
            DispatchQueue.main.async { [weak self] in
                guard let s = self else { return }
                self?.api.loadPhoto(imgURL: url, imgView: s.avatarGroup)
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarGroup.layer.cornerRadius = avatarGroup.frame.height/2.0
        avatarGroup.layer.masksToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
