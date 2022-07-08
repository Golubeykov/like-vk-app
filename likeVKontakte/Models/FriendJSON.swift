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
