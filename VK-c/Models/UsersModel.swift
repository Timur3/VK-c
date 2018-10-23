//
//  UsersModel.swift
//  VK-c
//
//  Created by Timur on 28.07.2018.
//  Copyright © 2018 Timur. All rights reserved.
//

import RealmSwift

public class User: Object, Decodable {
    @objc dynamic var id = 0
    @objc dynamic var firstName = ""
    @objc dynamic var lastName = ""
    @objc dynamic var deactivated = ""
    @objc dynamic var photo50 = ""
    @objc dynamic var photo100 = ""
    @objc dynamic var photo200: String?
    @objc dynamic var photo400: String?
    @objc dynamic var isOnline = 0
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case firstName = "first_name"
        case lastName = "last_name"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case photo200 = "photo_200_orig"
        case photo400 = "photo_400_orig"
        case isOnline = "online"
    }
    
    convenience init(id: Int, firstName: String, lastName: String, deactivated: String, photo50: String, photo100: String, photo200: String, photo400: String,
                     isOnline: Int) {
        self.init()
    }
    
    @objc open override class func primaryKey() -> String? {
        return "id"
    }
    
    func getFullName() -> String{
        return firstName+" "+lastName
    }
}
