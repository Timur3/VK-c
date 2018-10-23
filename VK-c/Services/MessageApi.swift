//
//  MessageApi.swift
//  VK-c
//
//  Created by Timur on 26.08.2018.
//  Copyright © 2018 Timur. All rights reserved.
//
import Foundation
import Alamofire
import SwiftyJSON

struct MessageApi {
    
    static var baseURL = "https://api.vk.com/method"
    static var versionApi = "5.80"

    // MARK: - Conversations
    // получение списка бесед
    static func getConversations(completion: @escaping (ResponseConversationsRoot) -> Void) {
        guard let accessToken = UserData.getToken() else {
            return
        }
        let methodName = "/messages.getConversations"
        let params: Parameters = [
            "access_token" : accessToken,
            //"user_id" : UserData.getCurrentUserId(),
            "extended" : "1",
            "count" : "200",
            "v" : versionApi
        ]
        Alamofire.request(baseURL+methodName, parameters: params).responseData(completionHandler: {response in
            if let result = response.result.value {
                let myResponse = try! JSONDecoder().decode(ResponseConversationsRoot.self, from: result)
                completion(myResponse)
            } else
            {
                print(Error.self)
            }
        })
    }
    
    // MARK: - getConversationsById
    // получение списка бесед
    static func getConversationsById(completion: @escaping (ResponseConversationsRoot) -> Void) {
        guard let accessToken = UserData.getToken() else {
            return
        }
        let methodName = "/messages.getConversationsById"
        let params: Parameters = [
            "access_token" : accessToken,
            //"user_id" : UserData.getCurrentUserId(),
            "extended" : "1",
            "count" : "200",
            "v" : versionApi
        ]
        Alamofire.request(baseURL+methodName, parameters: params).responseData(completionHandler: {response in
            if let result = response.result.value {
                let myResponse = try! JSONDecoder().decode(ResponseConversationsRoot.self, from: result)
                completion(myResponse)
            } else
            {
                print(Error.self)
            }
        })
    }
}
