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
        Group(name: "Kus", logoName: "Kus", numberOfParticipants: 4_142),
        Group(name: "Tsarap", logoName: "Tsatap", numberOfParticipants: 1_630),
        Group(name: "Meow", logoName: "Meow", numberOfParticipants: 743_882)
        ]
}
