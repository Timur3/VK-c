//
//  UserData.swift
//  VK-c
//
//  Created by Timur on 07.08.2018.
//  Copyright © 2018 Timur. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

class UserData {
    
    static func saveData(token: String, userId: Int) {
        UserDefaults.standard.set(token, forKey: "accessToken")
        UserDefaults.standard.set(userId, forKey: "userId")
    }
    
    static func getToken() -> String? {
        return UserDefaults.standard.string(forKey: "accessToken")
    }
    
    static func getCurrentUserId() -> Int? {
        return UserDefaults.standard.integer(forKey: "userId")
    }
    
    static func delData() {
        UserDefaults.standard.set("", forKey: "accessToken")
        UserDefaults.standard.set("", forKey: "userId")
    }
}
