//
//  NewsFeedHelpers.swift
//  VK-c
//
//  Created by Timur on 03.09.2018.
//  Copyright © 2018 Timur. All rights reserved.
//

import Foundation

func NewsParsing(response: ResponseNewsFeed) -> [NewsModelForCell] {
    
    var newsModelForCell = [NewsModelForCell]()
    
    for new in response.news {
        var n = NewsModelForCell()
        let sourceId = new.sourceId
        
        //MARK - Source
        if sourceId > 0 {
            n.sourseTitle = ((response.users.first{$0.id == sourceId})?.getFullName())!
            n.sourseAvatar = ((response.users.first{$0.id == sourceId})?.photo100)!
        } else {
            n.sourseTitle = ((response.groups.first{$0.id == abs(sourceId)})?.name)!
            n.sourseAvatar = ((response.groups.first{$0.id == abs(sourceId)})?.photo100)!
        }
        n.sourseDate = UnixTimeToDateTime(unixtime: new.date, fullFormat: false)
        
        //MARK - Attachments
        //to do
        
        n = AttachmentParsing(attachments: new.attachments, news: n)
        
        //MARK - Main body
        //n.mainImageUrl = new.
        n.mainText = new.text
        n.likeCount = "\(new.likes?.count ?? 0)"
        n.commentsCount = "\(new.comments.count)"
        n.repostCount = "\(new.reposts?.count ?? 0)"
        n.viewCount = "\(new.views?.count ?? 0)"
        
        n.nextFrom = response.nextFrom!
        
        newsModelForCell.append(n)
    }
    
    return newsModelForCell
}

func AttachmentParsing(attachments: [Attachments]?, news: NewsModelForCell) -> NewsModelForCell  {
    var model = news
    guard let attmts = attachments else {
        print("attachments is empty")
        return model
    }
    model.mainImageUrl = ""
    for attachment in attmts {
        //MARK - Photo
        if attachment.type == "photo" {
            let countPhotoSizes = attachment.photo!.photoSizes.count
            print("\(attachment.photo!.photoSizes.count)")
            model.mainImageUrl = attachment.photo!.photoSizes[countPhotoSizes - 1].url
        }
        
        //MARK - Doc
        if attachment.type == "doc" {
            
        }
        
        //MARK - Link
        if attachment.type == "link" {
            
        }
    }
    return model
}

