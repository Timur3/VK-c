//
//  UserData.swift
//  VK-c
//
//  Created by Timur on 07.08.2018.
//  Copyright © 2018 Timur. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

class UserDataService: UserDataProtocol {
   
    func saveData(token: String, userId: Int) {
        UserDefaults.standard.set(token, forKey: "accessToken")
        UserDefaults.standard.set(userId, forKey: "userId")
    }
    
    func getToken() -> String? {
        return UserDefaults.standard.string(forKey: "accessToken")
    }
    
    func getCurrentUserId() -> Int? {
        return UserDefaults.standard.integer(forKey: "userId")
    }
    
    func delData() {
        UserDefaults.standard.set("", forKey: "accessToken")
        UserDefaults.standard.set("", forKey: "userId")
    }
}
