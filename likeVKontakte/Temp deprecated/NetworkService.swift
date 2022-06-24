////
////  NetworkService.swift
////  likeVKontakte
////
////  Created by Антон Голубейков on 20.06.2022.
////
//
//import Foundation
//import Alamofire
//
//class NetworkService {
//    //MARK: - Тестовый запрос к открытому сервису погоды (URL Session)
//    let apiKey = "757a9f6c69245666336983d0aac5297d"
//    func loadWeatherData() {
////Прямой путь
////        let path = "https://api.openweathermap.org/data/2.5/weather?lat=55.7522&lon=37.6156&appid=\(apiKey)"
////        guard let url = URL(string: path) else { return }
////Путь через конструктор
//        var urlConstructor = URLComponents()
//        urlConstructor.scheme = "https"
//        urlConstructor.host = "api.openweathermap.org"
//        urlConstructor.path = "/data/2.5/weather"
//        urlConstructor.queryItems = [
//            URLQueryItem(name: "q", value: "Moscow"),
//            URLQueryItem(name: "appid", value: apiKey)
//        ]
//        guard let url = urlConstructor.url else { return }
//        
//        let session = URLSession.shared
//        let task = session.dataTask(with: url) { (data, response, error) in
//            if let error = error {
//                print(error)
//                return
//            }
//            if let data = data {
//                let json = try! JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
//                print(json)
//            }
//        }
//        task.resume()
//    }
//    
//    //MARK: - Тестовый запрос к открытому сервису погоды (Alamofire)
//    func loadWeatherWithAlamo() {
//        let path = "https://api.openweathermap.org/data/2.5/weather?lat=55.7522&lon=37.6156&appid=\(apiKey)"
//        AF.request(path).responseJSON { (response) in
////            if let error = error {
////                print(error)
////                return
////            }
//            if let value = response.value {
//                print(value)
//            }
//        }
//    }
//    
//}
//// MARK: - Доступ к API VK
//class VKService{
//    let token: String
//    let user_id: String
//    
//    init(token: String, user_id: String) {
//        self.token = token
//        self.user_id = user_id
//    }
//    // URL Session
//    func getFriends() {
//        
//        var urlConstructor = URLComponents()
//            urlConstructor.scheme = "https"
//            urlConstructor.host = "api.vk.com"
//            urlConstructor.path = "/method/friends.get"
//            urlConstructor.queryItems = [
//                URLQueryItem(name: "user_id", value: user_id),
//                URLQueryItem(name: "order_id", value: "hints"),
//                URLQueryItem(name: "fields", value: "city, country, photo_100, universities"),
//                URLQueryItem(name: "name_case", value: "nom"),
//                URLQueryItem(name: "access_token", value: token),
//                URLQueryItem(name: "v", value: "5.131")
//            ]
//        guard let url = urlConstructor.url else { return }
//        let session = URLSession.shared
//        let task = session.dataTask(with: url) { (data, response, error) in
//            if let error = error {
//                print(error)
//                return
//            }
//            if let data = data {
//                let json = try! JSONSerialization.jsonObject(with: data)
//                print(json)
//            }
//        }
//        task.resume()
//    }
//    // Alamofire
//    func getFriendsAF() {
//        var urlConstructor = URLComponents()
//            urlConstructor.scheme = "https"
//            urlConstructor.host = "api.vk.com"
//            urlConstructor.path = "/method/friends.get"
//            urlConstructor.queryItems = [
//                URLQueryItem(name: "user_id", value: user_id),
//                URLQueryItem(name: "order_id", value: "hints"),
//                URLQueryItem(name: "fields", value: "city, country, photo_100, universities"),
//                URLQueryItem(name: "name_case", value: "nom"),
//                URLQueryItem(name: "access_token", value: token),
//                URLQueryItem(name: "v", value: "5.131")
//            ]
//        guard let url = urlConstructor.url else { return }
////        AF.request(path).responseJSON { (response) in
////
////            if let value = response.value {
////                print(value)
////            }
////        }
//        AF.request(url).responseJSON { (response) in
//
//            if let value = response.value {
//                print(type(of: value))
//            }
//        }
//    }
//}
