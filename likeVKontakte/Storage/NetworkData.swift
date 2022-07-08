//
//  NetworkData.swift
//  likeVKontakte
//
//  Created by Антон Голубейков on 08.07.2022.
//

import Foundation

class NetworkData: NSObject {
 static let shared = NetworkData()
    
    private override init() {
        super.init()
    }
    private var token = ""
    private var loggedUserId = ""
    
    func addData(token: String, userID: String) {
        self.token = token
        self.loggedUserId = userID
    }
    
    func getToken() -> String {
        return token
    }
    
    func getLoggedUserId() -> String {
        return loggedUserId
    }
}
