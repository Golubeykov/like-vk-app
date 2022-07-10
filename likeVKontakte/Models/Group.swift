//
//  Group.swift
//  likeVKontakte
//
//  Created by Антон Голубейков on 19.06.2022.
//

//MARK: - здесь сразу модель соответствует JSON
import Foundation
import RealmSwift

struct RootGroupJSON: Decodable {
    let response: ResponseGroupJSON
}

// MARK: - Response
struct ResponseGroupJSON: Decodable {
    let items: [Group]
}

class Group: Object, Decodable {
    @objc dynamic var name: String
    @objc dynamic var logoName: String
    @objc dynamic var numberOfParticipants: Int
    
    enum CodingKeys: String, CodingKey {
        case name
        case logoName = "photo_200"
        case numberOfParticipants = "members_count"
    }
    
    required override init() {
        self.name = ""
        self.logoName = ""
        self.numberOfParticipants = 0
    }
    
    init(name: String, logoName: String, numberOfParticipants: Int) {
        self.name = name
        self.logoName = logoName
        self.numberOfParticipants = numberOfParticipants
    }
    
    required convenience init(from decoder: Decoder) throws {
        self.init()
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try values.decode(String.self, forKey: .name)
        self.logoName = try values.decode(String.self, forKey: .logoName)
        self.numberOfParticipants = try values.decode(Int.self, forKey: .numberOfParticipants)
    }
    
//    override class func primaryKey() -> String? {
//        "name"
//    }
//    override static func indexedProperties() -> [String] { return ["name"]
//    }
}

//struct Group: Decodable, Equatable {
//    var name: String
//    var logoName: String
//    var numberOfParticipants: Int
//
//    enum CodingKeys: String, CodingKey {
//        case name
//        case logoName = "photo_200"
//        case numberOfParticipants = "members_count"
//    }
//
//
//
//    static var allGroups: [Group] = [
//        Group(name:  "Кусь", logoName: "Kus", numberOfParticipants: 4_142),
//        Group(name: "Царапки", logoName: "Tsarap", numberOfParticipants: 1_630),
//        Group(name: "Милашки", logoName: "Meow", numberOfParticipants: 73_882),
//        Group(name: "Таскаем рыбу", logoName: "Fish", numberOfParticipants: 4_321)
//        ]
//}
