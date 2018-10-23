//
//  GroupsModel.swift
//  VK-c
//
//  Created by Timur on 28.07.2018.
//  Copyright © 2018 Timur. All rights reserved.
//

import RealmSwift

public struct ResponseGroupsRoot: Decodable {
    let responseGroupsRoot: ResponseGroups
    
    enum CodingKeys: String, CodingKey {
        case responseGroupsRoot = "response"
    }
}

public struct ResponseGroups: Decodable {
    let count: Int
    let groups: [Group]
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case groups = "items"
    }
}

public class Group: Object, Decodable {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var screenName: String = ""
    @objc dynamic var isClosed: Int = 0
    @objc dynamic var type: String = ""
    @objc dynamic var isAdmin: Int = 0
    @objc dynamic var isMember: Int = 0
    @objc dynamic var photo50: String = ""
    @objc dynamic var photo100: String = ""
    @objc dynamic var photo200: String = ""
    //@objc dynamic var descriptionGroup: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case screenName = "screen_name"
        case isClosed = "is_closed"
        case type = "type"
        case isAdmin = "is_admin"
        case isMember = "is_member"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case photo200 = "photo_200"
        //case descriptionGroup = "description"
    }
    
    convenience init (id: Int, name: String?, screenName: String?, isClosed: Int, type: String, isAdmin: Int, isMember: Int?, photo50: String?, photo100: String?, photo200: String?){
        self.init()
    }
    
    /*@objc open override class func primaryKey() -> String? {
     return "id"
     }*/
}

