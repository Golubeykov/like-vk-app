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
    func getFriends(completion: @escaping (Result<[FriendJSON], FriendJSONError>) -> Void) {
        
        var urlConstructor = URLComponents()
            urlConstructor.scheme = "https"
            urlConstructor.host = "api.vk.com"
            urlConstructor.path = "/method/friends.get"
            urlConstructor.queryItems = [
                //URLQueryItem(name: "lang", value: "en"),
                URLQueryItem(name: "user_id", value: user_id),
                URLQueryItem(name: "order_id", value: "name"),
                URLQueryItem(name: "count", value: "5"),
                URLQueryItem(name: "fields", value: "city, country, photo_100, universities"),
                URLQueryItem(name: "name_case", value: "nom"),
                URLQueryItem(name: "access_token", value: token),
                URLQueryItem(name: "v", value: "5.131")
            ]
        guard let url = urlConstructor.url else { return }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                print(error!.localizedDescription)
                completion(.failure(.serverError))
                return
            }
            guard let data = data else {
                completion(.failure(.noData))
                print("Не пришли данные")
                return
            }
            do {
            let friends = try JSONDecoder().decode(RootFriendJSON.self, from: data).response.items
                completion(.success(friends))
            } catch {
                print("Ошибка декодирования")
                print(error)
                completion(.failure(.decodeError))
            }
            
        }
        task.resume()
    }
    
    func getFriendsPhotos(for friend: Friend) {
        
        var urlConstructor = URLComponents()
            urlConstructor.scheme = "https"
            urlConstructor.host = "api.vk.com"
            urlConstructor.path = "/method/photos.getAll"
            urlConstructor.queryItems = [
                //URLQueryItem(name: "lang", value: "en"),
                URLQueryItem(name: "owner_id", value: friend.id),
                URLQueryItem(name: "count", value: "5"),
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
    
//    // Alamofire
//    func getFriendsAF() {
//        var urlConstructor = URLComponents()
//            urlConstructor.scheme = "https"
//            urlConstructor.host = "api.vk.com"
//            urlConstructor.path = "/method/friends.get"
//            urlConstructor.queryItems = [
//                URLQueryItem(name: "lang", value: "en"),
//                URLQueryItem(name: "user_id", value: user_id),
//                URLQueryItem(name: "order_id", value: "hints"),
//                URLQueryItem(name: "fields", value: "city, country, photo_100, universities"),
//                URLQueryItem(name: "name_case", value: "nom"),
//                URLQueryItem(name: "access_token", value: token),
//                URLQueryItem(name: "v", value: "5.131")
//            ]
//        guard let url = urlConstructor.url else { return }
//
//        AF.request(url).responseJSON { (response) in
//
//            if let value = response.value {
//                print(value)
//            }
//        }
//    }
//}

enum FriendJSONError: Error {
    case decodeError
    case noData
    case serverError
}
}
