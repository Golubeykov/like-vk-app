//
//  NetworkService.swift
//  likeVKontakte
//
//  Created by Антон Голубейков on 20.06.2022.
//

import Foundation
import Alamofire

// MARK: - Доступ к API VK
class VKService {
    let token: String
    let user_id: String
    
    init(token: String, user_id: String) {
        self.token = token
        self.user_id = user_id
    }
    // URL Session
    func getFriends() {
        
        var urlConstructor = URLComponents()
            urlConstructor.scheme = "https"
            urlConstructor.host = "api.vk.com"
            urlConstructor.path = "/method/friends.get"
            urlConstructor.queryItems = [
                URLQueryItem(name: "lang", value: "en"),
                URLQueryItem(name: "user_id", value: user_id),
                URLQueryItem(name: "order_id", value: "hints"),
                URLQueryItem(name: "fields", value: "city, country, photo_100, universities"),
                URLQueryItem(name: "name_case", value: "nom"),
                URLQueryItem(name: "access_token", value: token),
                URLQueryItem(name: "v", value: "5.131")
            ]
        guard let url = urlConstructor.url else { return }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            if let data = data {
                let json = try! JSONSerialization.jsonObject(with: data)
                print(json)
            }
        }
        task.resume()
    }
    // Alamofire
    func getFriendsAF() {
        var urlConstructor = URLComponents()
            urlConstructor.scheme = "https"
            urlConstructor.host = "api.vk.com"
            urlConstructor.path = "/method/friends.get"
            urlConstructor.queryItems = [
                URLQueryItem(name: "lang", value: "en"),
                URLQueryItem(name: "user_id", value: user_id),
                URLQueryItem(name: "order_id", value: "hints"),
                URLQueryItem(name: "fields", value: "city, country, photo_100, universities"),
                URLQueryItem(name: "name_case", value: "nom"),
                URLQueryItem(name: "access_token", value: token),
                URLQueryItem(name: "v", value: "5.131")
            ]
        guard let url = urlConstructor.url else { return }

        AF.request(url).responseJSON { (response) in

            if let value = response.value {
                print(value)
            }
        }
    }
}
