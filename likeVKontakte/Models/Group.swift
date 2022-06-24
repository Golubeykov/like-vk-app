//
//  Group.swift
//  likeVKontakte
//
//  Created by Антон Голубейков on 19.06.2022.
//

import Foundation

struct Group: Equatable {
    var name: String
    var logoName: String
    var numberOfParticipants: Int
    
    static let testGroups: [Group] = [
        Group(name:  "Кусь", logoName: "Kus", numberOfParticipants: 4_142),
        Group(name: "Царапки", logoName: "Tsarap", numberOfParticipants: 1_630),
        Group(name: "Милашки", logoName: "Meow", numberOfParticipants: 73_882),
        Group(name: "Таскаем рыбу", logoName: "Fish", numberOfParticipants: 4_321)
        ]
}
