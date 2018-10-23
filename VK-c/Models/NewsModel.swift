//
//  NewsModel.swift
//  VK-c
//
//  Created by Timur on 28.07.2018.
//  Copyright © 2018 Timur. All rights reserved.
//

import Foundation

struct News: Decodable {
    var type: String = ""       //тип списка новости, filters;
    var sourceId: Int = 0       //идентификатор источника новости (положительный — новость пользователя, отрицательный — новость группы);
    var date: Int = 0           //время публикации новости в формате unixtime;
    var postId: Int = 0         //находится в записях со стен и содержит идентификатор записи на стене владельца;
    var postType: String = ""   //находится в записях со стен, содержит тип новости (post или copy);
    var finalPost: String?
    var text: String = ""       //находится в записях со стен и содержит текст записи;
    var attachments: [Attachments]?
    //var attachment: Attachment
    var postSourse: PostSourse?
    var comments: Comment
    var likes: Likes?
    var reposts: Reposts?
    var views: Views?
    
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case sourceId = "source_id"
        case date = "date"
        case postId = "post_id"
        case postType = "post_type"
        case finalPost = "final_post"
        case text = "text"
        case attachments = "attachments"
        case postSourse = "post_source"
        case comments = "comments"
        case likes = "likes"
        case reposts = "reposts"
        case views = "views"
    }
    
    /*init(from decoder: Decoder) throws {
     let values = decoder.container(keyedBy: CodingKeys)
     attachments = values.decode(<#T##type: Bool.Type##Bool.Type#>, forKey: <#T##News.CodingKeys#>)
     }*/
}

// MARK: - Post_sourse
struct PostSourse: Decodable {
    var type: String = ""
    
    enum CodingKeys: String, CodingKey {
        case type = "type"
    }
}
// MARK: - Коментарии
struct Comment: Decodable {
    var count: Int = 0              //количество комментариев,
    var canPost: Int = 0            //может ли текущий пользователь комментировать запись (1 — может, 0 — не может);
    var groupsCanPost: Bool?
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case canPost = "can_post"
        case groupsCanPost = "groups_can_post"
    }
}
// MARK: - Likes
struct Likes: Decodable {
    var count: Int = 0      //число пользователей, которым понравилась запись
    var userLikes: Int = 0  //наличие отметки «Мне нравится» от текущего пользователя (1 — есть, 0 — нет),
    var canLike: Int = 0    //информация о том, может ли текущий пользователь поставить отметку «Мне нравится (1 — может, 0 — не может),
    var canPublish: Int = 0 //информация о том, может ли текущий пользователь сделать репост записи (1 — может, 0 — не может);
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case userLikes = "user_likes"
        case canLike = "can_like"
        case canPublish = "can_publish"
    }
}
// MARK: - Reposts
struct Reposts: Decodable {
    var count: Int = 0          //число пользователей, сделавших репост;
    var userReposted: Int = 0   //наличие репоста от текущего пользователя (0 — нет, 1 — есть);
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case userReposted = "user_reposted"
    }
}
// MARK: - Views
struct Views: Decodable {
    var count: Int = 0          // количество просмотров;
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
    }
}

// MARK: - News model for cell
struct NewsModelForCell {
    
    var sourseId: Int = 0
    var sourseAvatar: String = ""
    var sourseTitle: String = ""
    var sourseDate: String = ""
    var mainText: String = ""
    var mainImageUrl: String = ""
    var commentsCount: String = ""
    var likeCount: String = ""
    var repostCount: String = ""
    var viewCount: String = ""
    var startFrom: String = ""
    var nextFrom: String = ""
}

