//
//  FriendInfoCntr.swift
//  VK-c
//
//  Created by Timur on 04.08.2018.
//  Copyright © 2018 Timur. All rights reserved.
//

import UIKit

class FriendInfoVCntr: UIViewController {
    @IBOutlet weak var friendPhoto: UIImageView!
    
    var friend: User? {
        didSet {
            self.title = friend?.getFullName()
            guard let url = friend?.photo100 else { return }
            DispatchQueue.main.async { [weak self] in
                guard let s = self else { return }
                ApiWrapper.loadPhoto(imgURL: url, imgView: s.friendPhoto)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

