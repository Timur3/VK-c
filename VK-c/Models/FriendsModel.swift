//
//  FriendsModel.swift
//  VK-c
//
//  Created by Timur on 28.07.2018.
//  Copyright © 2018 Timur. All rights reserved.
//

import Foundation

public struct ResponseFriendsRoot: Decodable {
    let responseFriendsRoot: ResponseFriends
    
    enum CodingKeys: String, CodingKey {
        case responseFriendsRoot = "response"
    }
}

public struct ResponseFriends: Decodable {
    var count: Int
    var friends: [User]
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case friends = "items"
    }
}
