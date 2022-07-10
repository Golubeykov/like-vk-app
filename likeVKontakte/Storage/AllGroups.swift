//
//  AllGroups.swift
//  likeVKontakte
//
//  Created by Антон Голубейков on 08.07.2022.
//

import Foundation

//Синглтон списка всех групп
class AllGroupsStorage: NSObject {
    static let shared = AllGroupsStorage()
    
    private override init() {
        super.init()
        for group in hardCodeGroups {
            allGroups.append(group)
        }
    }
    
    private var allGroups = [Group]()
    
    func getAllGroups() -> [Group] {
        return allGroups
    }
    
    func addGroup(group: Group) {
        if !allGroups.contains(where: { $0 == group }) {
        allGroups.append(group)
        }
    }
    private var hardCodeGroups: [Group] = [
        Group(name:  "Кусь", logoName: "Kus", numberOfParticipants: 4_142),
        Group(name: "Царапки", logoName: "Tsarap", numberOfParticipants: 1_630),
        Group(name: "Милашки", logoName: "Meow", numberOfParticipants: 73_882),
        Group(name: "Таскаем рыбу", logoName: "Fish", numberOfParticipants: 4_321)
        ]
}

