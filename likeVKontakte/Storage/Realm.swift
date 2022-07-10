//
//  Realm.swift
//  likeVKontakte
//
//  Created by Антон Голубейков on 10.07.2022.
//
//
//import Foundation
//import RealmSwift
//
//class RealmStorage: NSObject {
//    static let shared = RealmStorage()
//    var realm: Realm = try! Realm()
//    
//    private override init() {
//        super.init()
//        
//        Realm.Configuration.defaultConfiguration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
//        do {
//            self.realm = try Realm()
//            print("REALM PATH:", realm.configuration.fileURL ?? "NO REALM PATH")
//        } catch {
//            print("Ошибка создания инстанса Realm")
//            print(error)
//        }
//    }
//}
//
//extension Realm {
//    public func safeWrite(_ block: (() throws -> Void)) throws {
//        if isInWriteTransaction {
//            try block()
//        } else {
//            try write(block)
//        }
//    }
//}
