//
//  NewsFeedModel.swift
//  VK-c
//
//  Created by Timur on 28.07.2018.
//  Copyright © 2018 Timur. All rights reserved.
//
import RealmSwift

public struct ResponseNewsFeedRoot: Decodable {
    let responseNewsFeedRoot: ResponseNewsFeed
    
    enum CodingKeys: String, CodingKey {
        case responseNewsFeedRoot = "response"
    }
}
public struct ResponseNewsFeed: Decodable {
    var news: [News]      //массив новостей для текущего пользователя;
    var users: [User]     //информация о пользователях, которые находятся в списке новостей;
    var groups: [Group]     //информация о группах, которые находятся в списке новостей;
    var startFrom: String?
    var newOffset: String?  //содержит offset, необходимо, для того, чтобы получить следующую часть новостей;
    var nextFrom: String?    //содержит start_from, который необходимо передать, для того, чтобы получить следующую часть новостей. Позволяет избавиться от дубликатов, которые могут возникнуть при появлении новых новостей между вызовами этого метода.
    
    enum CodingKeys: String, CodingKey {
        case news = "items"
        case users = "profiles"
        case groups = "groups"
        case newOffset = "new_offset"
        case nextFrom = "next_from"
        case startFrom = "start_from"
    }
    
}
