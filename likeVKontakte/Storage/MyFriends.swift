//
//  MyFriends.swift
//  likeVKontakte
//
//  Created by Антон Голубейков on 04.07.2022.
//

import Foundation

//Синглтон списка моих друзей
class MyFriendsStorage: NSObject {
    static let shared = MyFriendsStorage()
    
    private override init() {
        super.init()
        for friend in hardCodeFriends {
            self.addFriend(friend: friend)
        }
    }
    
    private var myFriends = [Friend]()
    
    func getMyFriends() -> [Friend] {
        return myFriends
    }
    
    func addFriend(friend: Friend) {
        if !myFriends.contains(where: { $0 == friend }) {
        myFriends.append(friend)
        }
    }
    
    private let hardCodeFriends: [Friend] = [
        Friend(id: "", name: "Лёлик", imageName: "Lelik", photosLibrary: ["meow", "kus", "catLogo","fish"]),
    Friend(id: "", name: "Миса", imageName: "Misa", photosLibrary: ["kus", "tsarap", "fish","Stepan"]),
    Friend(id: "", name: "Степан", imageName: "Stepan", photosLibrary: ["test", "kus", "tsarap","meow"]),
        Friend(id: "", name: "Матильда", imageName: "matilda", photosLibrary: ["test", "kus", "tsarap","meow"]),
        Friend(id: "", name: "Рыжик", imageName: "Ryzik", photosLibrary: [])
    ]
}
