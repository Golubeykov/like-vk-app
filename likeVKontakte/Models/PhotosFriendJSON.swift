//
//  PhotosFriendJSON.swift
//  likeVKontakte
//
//  Created by Антон Голубейков on 08.07.2022.
//

import Foundation

struct Welcome: Decodable {
    let response: Response
}

struct Response: Decodable {
    let items: [Item]
}

struct Item: Decodable {
    let sizes: [Size]

    enum CodingKeys: String, CodingKey {
        case sizes
    }
}

struct Size: Decodable {
    let url: String
}
