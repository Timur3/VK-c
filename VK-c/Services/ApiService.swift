//
//  ApiWrapper.swift
//  VK-c
//
//  Created by Timur on 26.07.2018.
//  Copyright © 2018 Timur. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct ApiService {
    
    let baseURL: StUserDataService
    let versionApi: String
    let userData = UserData()
    
    init() {
        versionApi = "5.101"
        baseURL = "https://api.vk.com/method"
    }
    
    var loginURL: URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "oauth.vk.com"
        components.path = "/authorize"
        components.queryItems = [
            URLQueryItem(name: "client_id", value: "6308669"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_url", value: "https//oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "405510"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: versionApi)
        ]
        
        return URLRequest(url: components.url!)
    }
    
    func getNewsFeed(startFrom: String, resultCount: Int, completion: @escaping ([NewsModelForCell], String) -> Void){
        guard let accessToken = userData.getToken() else {
            return
        }
        let methodName = "/newsfeed.get"
        let params: Parameters = [
            "filters" : "post",
            "access_token" : accessToken,
            "count": resultCount,
            "start_from": startFrom,
            "v" : versionApi
        ]
        
        DispatchQueue.global().async {
            Alamofire.request(self.baseURL+methodName, parameters: params)
                .responseData(queue: DispatchQueue.global()) { response in
                    if let result = response.result.value {
                        let myResponse = try! JSONDecoder().decode(ResponseNewsFeedRoot.self, from: result)
                        
                        DispatchQueue.main.async {
                            completion(NewsParsing(response: myResponse.responseNewsFeedRoot), myResponse.responseNewsFeedRoot.nextFrom!)
                        }
                    } else
                    {
                        print(Error.self)
                    }
                    
            }
        }
        
    }
    // MARK: - Группа
    // получение списка групп пользователя
    func getGroups(completion: @escaping ([Group]) -> Void) {
        guard let accessToken = userData.getToken() else {
            return
        }
        let methodName = "/groups.get"
        let params: Parameters = [
            "access_token" : accessToken,
            "extended" : "1",
            "fields": "description,activity,members_count",
            "count" : "50",
            "v" : versionApi,
            ]
        DispatchQueue.global().async {
            Alamofire.request(self.baseURL+methodName, parameters: params).responseData(completionHandler: {response in
                if let result = response.result.value {
                    let myResponse = try! JSONDecoder().decode(ResponseGroupsRoot.self, from: result)
                    completion(myResponse.responseGroupsRoot.groups)
                } else
                {
                    print(Error.self)
                }
            })
        }
        
    }
    //MARK: - получение информации о группе по Id
    // todo доделать
    func getGroupById(for id: String, completion: @escaping ([Group]) -> Void){
        let methodName = "/groups.getById"
        let params: Parameters = [
            //"access_token" : UserData.getToken(),
            "group_id": id,
            "type": "group",
            "fields": "description,activity,members_count",
            "sort": "0",
            "count": "50",
            "v": versionApi
        ]
        Alamofire.request(baseURL+methodName, parameters: params).responseData(completionHandler: { response in
            if let result = response.result.value {
                let myResponse = try! JSONDecoder().decode(ResponseGroupsRoot.self, from: result)
                completion(myResponse.responseGroupsRoot.groups)
            }
        })
    }
    
    // получение списка друзей
    func getFriends(completion: @escaping ([User]) -> Void) {
        guard let accessToken = userData.getToken() else {
            return
        }
        
        let methodName = "/friends.get"
        let params: Parameters = [
            "access_token" : accessToken,
            "order" : "name",
            "count" : "5000",
            "fields": "id, first_name, last_name, photo_50, photo_100, photo_200, photo_400_orig",
            "v" : versionApi
        ]
        DispatchQueue.global().async {
            Alamofire.request(self.baseURL+methodName, parameters: params).responseData(completionHandler: { response in
                if let result = response.result.value {
                    let myResponse = try! JSONDecoder().decode(ResponseFriendsRoot.self, from: result)
                    completion(myResponse.responseFriendsRoot.friends)
                }
            })
        }
    }
    
    func getMembersGroup(groupId: Int, label: UILabel) {
        guard let accessToken = userData.getToken() else {
            return
        }
        let methodName = "/groups.getMembers"
        let params: Parameters = [
            "access_token" : accessToken,
            "group_id" : groupId,
            "count" : "1",
            "v" : versionApi
        ]
        DispatchQueue.global().sync {
            Alamofire.request(baseURL+methodName, parameters: params).responseData(completionHandler: {response in
                if let result = response.result.value {
                    let myResponse = try! JSONDecoder().decode(ResponseGroupMembersRoot.self, from: result)
                    label.text = String(myResponse.responseGroupMembersRoot.count)+" подписчиков"
                }
            })
        }
    }
    
    func searchGroups(for query: String, completion: @escaping ([Group]) -> Void) {
        guard let accessToken = userData.getToken() else {
            return
        }
        let methodName = "/groups.search"
        let params: Parameters = [
            "access_token" : accessToken,
            //"user_id" : userId,
            "q": query,
            "type": "group",
            "offset": "0",
            "fields": "description,activity",
            "sort": "0",
            "count": "50",
            "v": versionApi
        ]
        DispatchQueue.global().sync {
            Alamofire.request(baseURL+methodName, parameters: params).responseData(completionHandler: { response in
                if let result = response.result.value {
                    let myResponse = try! JSONDecoder().decode(ResponseGroupsRoot.self, from: result)
                    completion(myResponse.responseGroupsRoot.groups)
                }
            })
        }
    }
    
    func loadPhoto(imgURL: String, imgView: UIImageView) {
        DispatchQueue.main.async {
            Alamofire.request(imgURL).responseData {
                response in
                guard let imageData = response.data,
                    let img = UIImage(data: imageData) else { return }
                imgView.image = img
            }
        }
    }
    
}
