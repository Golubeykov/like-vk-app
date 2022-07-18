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
}

struct NewsPostItem: Decodable {
    let source_id: Int
    let text: String
    let attachments: [ItemAttachmentNewsPost]?
    
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


