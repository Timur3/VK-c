//
//  MessagesModel.swift
//  VK-c
//
//  Created by Timur on 14.08.2018.
//  Copyright © 2018 Timur. All rights reserved.
//

import RealmSwift

struct ResponseConversationsRoot: Decodable {
    let responseConversationsRoot: ResponseConversations
    
    enum CodingKeys: String, CodingKey {
        case responseConversationsRoot = "response"
    }
}

struct ResponseConversations: Decodable {
    let count: Int
    let conversations: [ConversationAndLastMessage]
    let unreadCount: Int = 0
    let users: [User]
    let groups: [Group]
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case conversations = "items"
        case unreadCount = "unread_count"
        case users = "profiles"
        case groups
    }
    
}

struct ConversationAndLastMessage: Decodable {
    let conversation: Conversation
    let lastMessage: Message
    
    enum CodingKeys: String, CodingKey {
        case conversation
        case lastMessage = "last_message"
    }
}

// MARK: - Conversations (Сообщения, переписка)
struct Conversation: Decodable {
    let peer: Peer? //информация о собеседнике
    let inRead: Int //идентификатор последнего прочтенного входящего сообщения.
    let outRead: Int //идентификатор последнего прочтенного исходящего сообщения.
    let lastMessageId: Int
    let unreadCount: Int? //число непрочитанных сообщений.
    let important: Bool?
    let unanswered: Bool?
    let pushSettings: PushSettings? //настройки Push-уведомлений
    let canWrite: CanWrite?
    let chatSettings: ChatSettings?

    enum CodingKeys: String, CodingKey {
        case peer = "peer"
        case inRead = "in_read"
        case outRead = "out_read"
        case lastMessageId = "last_message_id"
        case unreadCount = "unread_count"
        case important = "important"
        case unanswered = "unanswered"
        case pushSettings = "push_settings"
        case canWrite = "can_write"
        case chatSettings = "chat_settings"
    }
}

// MARK: - messages
struct Message: Decodable {
    let id: Int //идентификатор сообщения.
    let date: Int //время отправки в Unixtime.
    let peerId: Int //идентификатор назначения.
    let fromId: Int //идентификатор отправителя.
    let text: String //текст сообщения.
    let randomId: Int? //идентификатор, используемый при отправке сообщения. только для исходящих сообщений.
    let attachments: [Attachments]?
    let important: Bool
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case date = "date"
        case peerId = "peer_id"
        case fromId = "from_id"
        case text
        case randomId = "random_id"
        case attachments = "attachments"
        case important = "important"
    }
}

// MARK: - информация о собеседнике
struct Peer: Decodable {
    let id: Int
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case type = "type"
    }
}

// MARK: - настройки Push-уведомлений
struct PushSettings: Decodable {
    let disabledUntil: Int //timestamp, до которого оповещения отключены;
    let disabledForever: Bool //передается в случае, если оповещения отключены навсегда, содержит true;
    let noSound: Bool
    
    enum CodingKeys: String, CodingKey {
        case disabledUntil = "disabled_until"
        case disabledForever = "disabled_forever"
        case noSound = "no_sound"
    }
}

// MARK: - информация о том, может ли пользователь писать в диалог.
struct CanWrite: Decodable {
    let allowed: Bool //true, если пользователь может писать в диалог;
    let reason: Int? //код ошибки для allowed = false
    
    enum CodingKeys: String, CodingKey {
        case allowed = "allowed"
        case reason = "reason"
    }
}

// MARK: - настройки чата
struct ChatSettings: Decodable {
    let membersCount: Int // число участников;
    let title: String //название;
    let state: String //cтатус текущего пользователя. Возможные значения:
    
    enum CodingKeys: String, CodingKey {
        case membersCount = "members_count"
        case title = "title"
        case state = "state"
    }
}

// MARK: - conversation model for cell
struct ConversationModelForCell {
    var friendsAvatar: String = ""
    var friendName: String = ""
    var lastMessageText: String = ""
    var date: String = ""
    var isOnline: Bool = false
}

