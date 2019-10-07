//
//  AllGroupsTVCell.swift
//  VK-c
//
//  Created by Timur on 06.08.2018.
//  Copyright © 2018 Timur. All rights reserved.
//

import UIKit

class AllGroupsTVCell2: UITableViewCell {
    
    let api = ApiService()
    
    @IBOutlet weak var avatarGroup: UIImageView!
    @IBOutlet weak var nameGroup: UILabel!
    @IBOutlet weak var noteGroup: UILabel!
    @IBOutlet weak var activityGroup: UILabel!
    
    var allGroup: Group? {
        didSet {
            nameGroup.text = allGroup?.name
            noteGroup.text = "\(allGroup?.membersCount ?? 0) подписчика(-ов)"
            activityGroup.text = allGroup?.activity
            
            guard let url = allGroup?.photo100 else { return }
            DispatchQueue.main.async { [weak self] in
                guard let s = self else { return }
                self?.api.loadPhoto(imgURL: url, imgView: s.avatarGroup)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarGroup.layer.cornerRadius = avatarGroup.frame.height / 2.0
        avatarGroup.layer.masksToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
