//
//  Group.swift
//  likeVKontakte
//
//  Created by Антон Голубейков on 19.06.2022.
//

//MARK: - здесь сразу модель соответствует JSON
import Foundation

struct RootGroupJSON: Decodable {
    let response: ResponseGroupJSON
}

// MARK: - Response
struct ResponseGroupJSON: Decodable {
    let items: [Group]
}

struct Group: Decodable, Equatable {
    var name: String
    var logoName: String
    var numberOfParticipants: Int
    
    enum CodingKeys: String, CodingKey {
        case name
        case logoName = "photo_200"
        case numberOfParticipants = "members_count"
    }
    
    static var allGroups: [Group] = [
        Group(name:  "Кусь", logoName: "Kus", numberOfParticipants: 4_142),
        Group(name: "Царапки", logoName: "Tsarap", numberOfParticipants: 1_630),
        Group(name: "Милашки", logoName: "Meow", numberOfParticipants: 73_882),
        Group(name: "Таскаем рыбу", logoName: "Fish", numberOfParticipants: 4_321)
        ]
}
