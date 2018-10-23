//
//  ModelHelpers.swift
//  VK-c
//
//  Created by Timur on 16.08.2018.
//  Copyright © 2018 Timur. All rights reserved.
//

import Foundation

func UnixTimeToDateTime(unixtime: Int, fullFormat: Bool = false) -> String {
    let date = NSDate(timeIntervalSince1970: Double(unixtime))
        
    let dayTimePeriodFormatter = DateFormatter()
    if (fullFormat) {
        dayTimePeriodFormatter.dateFormat = "dd.MM.yyyy hh:mm"
    } else {
        dayTimePeriodFormatter.dateFormat = "dd.MM.yyyy"
    }
    let dateString = dayTimePeriodFormatter.string(from: date as Date)
    return dateString
}

func CreateConversationModelForCell(_ r: ConversationAndLastMessage, u: [User], g: [Group]) -> ConversationModelForCell {
    
    var m = ConversationModelForCell()
    m.lastMessageText = (r.lastMessage.text)
    m.date = UnixTimeToDateTime(unixtime: r.lastMessage.date)
    m.isOnline = false //r.conversation
    if (r.conversation.peer?.type == "user") {
        m.friendName = (u.first{$0.id == r.conversation.peer?.id})!.getFullName()
        m.friendsAvatar = (u.first{$0.id == r.conversation.peer?.id})!.photo100
    } else if (r.conversation.peer?.type == "group") {
        m.friendName = (g.first{$0.id == abs((r.conversation.peer?.id)!)})!.name
        m.friendsAvatar = (g.first{$0.id == abs((r.conversation.peer?.id)!)})!.photo100
    }
    return m
}

func GetUrlMaxSizePhoto(arrayPhoto: [PhotoSize]) -> String? {
    
    var array: [PhotoSize] = []
    array = arrayPhoto.sorted(by: { $0.width! > $1.width! })
    
    return array[0].url
}

