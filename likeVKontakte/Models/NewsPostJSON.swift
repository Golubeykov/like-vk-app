//
//  NewsPostJSON.swift
//  likeVKontakte
//
//  Created by Антон Голубейков on 14.07.2022.
//

import Foundation


// MARK: - Root level in JSON
struct NewsPostRoot: Decodable {
    let response: NewsPostResponse
}

// MARK: - Response
struct NewsPostResponse: Decodable {
    let items: [NewsPostItem]
    let profiles: [NewsPostProfile]
    let groups: [NewsPostGroup]
}

struct NewsPostItem: Decodable {
    let source_id: Int
    let text: String
    let attachments: [ItemAttachmentNewsPost]?
    let likes: Likes
}
struct Likes: Decodable {
    let count: Int
}

struct NewsPostGroup: Decodable {
    let id: Int
    let name: String
    let photo100: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case photo100 = "photo_100"
    }
}

struct NewsPostProfile: Decodable {
    let id: Int
    let screenName: String
    let photo100: String
    let firstName, lastName: String

    enum CodingKeys: String, CodingKey {
        case id
        case screenName = "screen_name"
        case photo100 = "photo_100"
        case firstName = "first_name"
        case lastName = "last_name"
    }
}

struct ItemAttachmentNewsPost: Decodable {
    let photo: LinkPhotoNewsPost?
}

struct LinkPhotoNewsPost: Decodable {
    let sizes: [Size]
}

struct SizeNewsPost: Decodable {
    let url: String?
}


