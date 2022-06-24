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
    }
    
    private var myGroups = [Group]()
    
    func getMyGroups() -> [Group] {
        return myGroups
    }
    
    func addGroup(group: Group) {
        if !myGroups.contains(where: { $0 == group }) {
        myGroups.append(group)
        }
    }
    
    
}
