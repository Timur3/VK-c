//
//  CroupInfoTVCntr.swift
//  VK-c
//
//  Created by Timur on 06.08.2018.
//  Copyright © 2018 Timur. All rights reserved.
//

import UIKit

class GroupInfoCntr: UIViewController {


    @IBOutlet weak var groupAvatar: UIImageView!
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var groupType: UILabel!
    @IBOutlet weak var GroupMemberCount: UILabel!
    var isMemberI: Int = 0
    
    var groupInfo: Group?

    @IBAction func GroupJoinOrExit(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if groupInfo?.id != 0 {
          
            isMemberI = (groupInfo?.isMember)!
            groupName.text = groupInfo?.name
            groupType.text = groupInfo?.type
            guard let url = groupInfo?.photo200 else { return }
            DispatchQueue.main.async { [weak self] in
                guard let s = self else { return }
                ApiWrapper.loadPhoto(imgURL: url, imgView: s.groupAvatar)
            }
            let but = view.viewWithTag(50) as! UIButton
            if isMemberI == 0 {
                but.setTitle("Вступить", for: .normal)
            } else {
                but.setTitle("Вы подписаны", for: .normal)
            }
            
            groupAvatar.layer.cornerRadius = groupAvatar.frame.height / 2
            groupAvatar.layer.masksToBounds = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
