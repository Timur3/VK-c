//
//  NewsFeedTVCell.swift
//  VK-c
//
//  Created by Timur on 26.07.2018.
//  Copyright © 2018 Timur. All rights reserved.
//

import UIKit

class NewsFeedTVCell: UITableViewCell {
    @IBOutlet weak var iconNewsFeedImg: UIImageView!
    @IBOutlet weak var titNewsFeed: UILabel!
    @IBOutlet weak var datetimeNewsFeed: UILabel!
    @IBOutlet weak var mainImageCell: UIImageView!
    @IBOutlet weak var mainText: UILabel!
 
    // Блок статистики
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var commentsCount: UILabel!
    @IBOutlet weak var repostCount: UILabel!
    @IBOutlet weak var viewCount: UILabel!
    
    var newsFeed: NewsModelForCell? {
        didSet {
            
            ApiWrapper.loadPhoto(imgURL: (newsFeed?.sourseAvatar)!, imgView: iconNewsFeedImg)
            titNewsFeed.text = newsFeed?.sourseTitle
            datetimeNewsFeed.text = newsFeed?.sourseDate
            // Main body
            mainText.text = newsFeed?.mainText
            ApiWrapper.loadPhoto(imgURL: (newsFeed?.mainImageUrl)!, imgView: mainImageCell)
            // Блок статистики
            commentsCount.text = newsFeed?.commentsCount
            likeCount.text = newsFeed?.likeCount
            repostCount.text = newsFeed?.repostCount
            viewCount.text = newsFeed?.viewCount
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        iconNewsFeedImg.layer.cornerRadius = iconNewsFeedImg.frame.height/2.0
        iconNewsFeedImg.layer.masksToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

