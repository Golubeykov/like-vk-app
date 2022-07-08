//
//  FriendJSON.swift
//  likeVKontakte
//
//  Created by Антон Голубейков on 07.07.2022.
//

import Foundation

struct RootFriendJSON: Decodable {
    let response: ResponseFriendJSON
}

struct ResponseFriendJSON: Decodable {
    let items: [FriendJSON]
}

struct FriendJSON: Decodable {
    var id: Int
    var name: String
    var imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "first_name"
        case imageURL = "photo_200"
    }
}

//class FriendJSON: Decodable {
//    var id: String = ""
//    var name: String = ""
//    var imageURL: String = ""
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case name = "first_name"
//        case imageURL = "photo_100"
//    }
//    required convenience init(from decoder: Decoder) throws {
//        self.init()
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        self.id = try values.decode(String.self, forKey: .id)
//        self.name = try values.decode(String.self, forKey: .name)
//        self.imageURL = try values.decode(String.self, forKey: .imageURL)
//    }
//}
