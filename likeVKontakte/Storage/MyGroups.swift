//
//  MyGroups.swift
//  likeVKontakte
//
//  Created by Антон Голубейков on 24.06.2022.
//

import Foundation

//Синглтон списка моих групп
class MyGroupsStorage: NSObject {
    static let shared = MyGroupsStorage()
    
    private override init() {
        super.init()
        for group in hardCodeGroups {
            myGroups.append(group)
        }
    }
    private var myGroups = [Group]()
    
    func getMyGroups() -> [Group] {
        return myGroups
    }
    
    func addGroup(group: Group) {
        if !myGroups.contains(where: { $0.name == group.name }) {
        myGroups.append(group)
        }
    }
    private var hardCodeGroups: [Group] = [
        Group(name:  "Кусь", logoName: "Kus", numberOfParticipants: 41411),
        Group(name: "Царапки", logoName: "Tsarap", numberOfParticipants: 1630),
        Group(name: "Милашки", logoName: "Meow", numberOfParticipants: 73882),
        Group(name: "Таскаем рыбу", logoName: "Fish", numberOfParticipants: 4321)
        ]
    
}
