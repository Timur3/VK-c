//
//  AttachmentsModel.swift
//  VK-c
//
//  Created by Timur on 28.07.2018.
//  Copyright © 2018 Timur. All rights reserved.
//

struct Attachments: Decodable {
    var type: String?
    var photo: Photo?
    //var postedPhoto: PostedPhoto?
    var link: Link?
    var doc: Doc?
    var video: Video?
    var audio: Audio?
    
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case photo
        case link
        case doc
        case video
        case audio
        //case postedPhoto = ""
    }
}

// MARK: - Фотография (type = photo)
struct Photo: Decodable {
    var id: Int = 0
    var albumId: Int = 0
    var ownerId: Int = 0
    var userId: Int?
    var text: String?
    var date: Int?
    var photoSizes: [PhotoSize]
    var photo75: String?
    var photo130: String?
    var photo604: String?
    var photo807: String?
    var photo1280: String?
    var photo2560: String?
    var width: Int?
    var height: Int?
    var postId: Int?
    var accessKey: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case albumId = "album_id"
        case ownerId = "owner_id"
        case userId = "user_id"
        case text = "text"
        case date = "date"
        case photoSizes = "sizes"
        case photo75 = "photo_75"
        case photo130 = "photo_130"
        case photo604 = "photo_604"
        case photo807 = "photo_807"
        case photo1280 = "photo_1280"
        case photo2560 = "photo_2560"
        case width = "width"
        case height = "height"
        case postId = "post_id"
        case accessKey = "access_key"
    }
}

struct PhotoSize: Decodable {
    var type: String = ""
    var url: String = ""
    var width: Int?
    var height: Int?
}
// MARK: - Фотография, загруженная напрямую (type = posted_photo)
struct PostedPhoto: Decodable {
    var id: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
    }
}
// MARK: - Видеозапись (type = video)
struct Video: Decodable {
    var id: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
    }
}
// MARK: - Аудиозапись (type = audio)
struct Audio: Decodable {
    var id: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
    }
}
// MARK: - Документ (type = doc)
struct Doc: Decodable {
    var id: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
    }
}
// MARK: - Граффити (type = graffiti)
struct Graffiti: Decodable {
    var id: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
    }
}
// MARK: - Ссылка (type = link)
struct Link: Decodable {
    var url: String?
    var title: String?
    var caption: String?
    var description: String?
    var photo: Photo?
    //var product:
    var button: Button?
    var preview_page: String?
    var preview_url: String?
    
    enum CodingKeys: String, CodingKey {
        case url = "url"
    }
}
struct Button: Decodable {
    var title: String?
    var action: Action?
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case action
    }
}

struct Action: Decodable {
    var type: String?
    var url: String?
    
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case url = "url"
    }
}

// MARK: - Заметка (type = note)
struct Note: Decodable {
    var id: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
    }
}
// MARK: - Контент приложения (type = app)
struct App: Decodable {
    var id: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
    }
}
// MARK: - Опрос (type = poll)
struct Poll: Decodable {
    var id: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
    }
}
// MARK: - Вики-страница (type = page)
struct Page: Decodable {
    var id: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
    }
}
// MARK: - Альбом с фотографиями (type=album)
struct Album: Decodable {
    var id: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
    }
}
// MARK: - Список фотографий (type=photos_list)
struct PhotoList: Decodable {
    var id: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
    }
}
// MARK: - Товар (type = market)
struct Market: Decodable {
    var id: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
    }
}
// MARK: - Подборка товаров (type = market_album)
struct MarketAlbum: Decodable {
    var id: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
    }
}
// MARK: - Стикер (type = sticker)
struct Sticker: Decodable {
    var id: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
    }
}
// MARK: - Карточки (type = pretty_cards)
struct PrettyCards: Decodable {
    var id: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
    }
}
