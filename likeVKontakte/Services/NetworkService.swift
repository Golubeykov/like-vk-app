//
//  NetworkService.swift
//  likeVKontakte
//
//  Created by Антон Голубейков on 20.06.2022.
//

import Foundation
import Alamofire
import RealmSwift

// MARK: - Доступ к API VK
class VKService {
    let token: String
    let user_id: String
    
    init(token: String, user_id: String) {
        self.token = token
        self.user_id = user_id
    }
    
    //Общая часть сетевых запросов
    private let scheme = "https"
    private let host = "api.vk.com"
    enum vkMethods: String {
        case getFriends = "/method/friends.get"
        case getPhotosByUser = "/method/photos.getAll"
        case getGroups = "/method/groups.get"
        case getNewsPosts = "/method/newsfeed.get"
    }
    let session = URLSession(configuration: .default)
    
    //MARK: - getFriends URL Session подгружаем json и парсим сразу
    func getFriends(completion: @escaping (Result<[FriendJSON], JSONError>) -> Void) {
        
        var urlConstructor = URLComponents()
        urlConstructor.scheme = scheme
        urlConstructor.host = host
        urlConstructor.path = vkMethods.getFriends.rawValue
        urlConstructor.queryItems = [
            URLQueryItem(name: "user_id", value: user_id),
            URLQueryItem(name: "order_id", value: "name"),
            URLQueryItem(name: "count", value: "5"),
            URLQueryItem(name: "fields", value: "city, country, photo_200, universities"),
            URLQueryItem(name: "name_case", value: "nom"),
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "v", value: "5.131")
        ]
        guard let url = urlConstructor.url else { return }
        
        let session = session
        
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
    
    //MARK: - getFriendPhotos Сохраняем json в FileStorage после загрузки
    func getFriendsPhotos(for friend: Friend, completion: @escaping (Result<URL, JSONError>) -> Void) {
        
        var urlConstructor = URLComponents()
        urlConstructor.scheme = scheme
        urlConstructor.host = host
        urlConstructor.path = vkMethods.getPhotosByUser.rawValue
        urlConstructor.queryItems = [
            URLQueryItem(name: "owner_id", value: friend.id),
            URLQueryItem(name: "count", value: "5"),
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "v", value: "5.131")
        ]
        guard let url = urlConstructor.url else { return }
        
        let session = session
        let downloadTask = session.downloadTask(with: url) { urlFile, response, error in
            guard error == nil else {
                print(error!.localizedDescription)
                completion(.failure(.serverError))
                return
            }
            if urlFile != nil {
                do {
                    let path = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true)[0]+"/\(friend.name)PhotosData.json"
                    let urlPath = URL(fileURLWithPath: path)
                    
                    if !FileManager.default.fileExists(atPath: path) {
                        try FileManager.default.copyItem(at: urlFile!, to: urlPath)
                        completion(.success(urlPath))
                    } else {
                        completion(.success(urlPath))
                    }
                } catch {
                    print(error)
                    completion(.failure(.savingToFileManagerError))
                    return
                }
            } else {
                completion(.failure(.noData))
                print("Не пришли данные")
                return
            }
        }
        downloadTask.resume()
        
    }
    
    //MARK: - Alamofire getGroups (получаем данные из сети, кладем их в Realm, а читаем и отображем в приложениии из Realm)
    func getGroupsAF(completion: @escaping () -> Void) {
        var urlConstructor = URLComponents()
        urlConstructor.scheme = scheme
        urlConstructor.host = host
        urlConstructor.path = vkMethods.getGroups.rawValue
        urlConstructor.queryItems = [
            URLQueryItem(name: "user_id", value: user_id),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "fields", value: "members_count"),
            URLQueryItem(name: "count", value: "7"),
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "v", value: "5.131")
        ]
        guard let url = urlConstructor.url else { return }
        var groups = [Group]()
        AF.request(url).responseDecodable { (response: DataResponse<Group, AFError>) in
            if let error = response.error {
                print(error)
            }
            guard let data = response.data else {
                return
            }
            do {
                groups = try JSONDecoder().decode(RootGroupJSON.self, from: data).response.items
            } catch {
                print("Ошибка декодирования")
                print(error)
            }
            self.saveGroupsInRealm(groups, completion: completion)
        }
    }
    
    
    func saveGroupsInRealm (_ groups: [Group], completion: @escaping ()->Void) {
        // На бою так не делаем, чтобы не положить базу)) Это чисто для теста
        Realm.Configuration.defaultConfiguration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        do {
            let realm = try Realm()
            realm.autorefresh = true
            //Можно фильтровать ответы из базы
            //let networkGroupsFiltered = realm.objects(Group.self).filter("name BEGINSWITH 'B'")
            //print("Filtered groups in Realm:", networkGroupsFiltered.count)
            print("Realm file path:", realm.configuration.fileURL ?? "No Realm path")
            let oldGroupsList = realm.objects(Group.self)
            realm.beginWrite()
            //MARK: Дает краш, если удалять. Пока реализую чисто апдейтом
            realm.delete(Array(oldGroupsList))
            realm.add(groups)
            try realm.commitWrite()
            DispatchQueue.main.async {
                print("Data saved in Realm")
                completion()
            }
        } catch {
            print(error)
            print("Ошибка сохранения данных в Realm")
        }
    }
    
    //MARK: - Загрузка ленты новостей
    func getNewsPosts(completion: @escaping (Result<([NewsPostItem],[NewsPostGroup],[NewsPostProfile]), JSONError>) -> Void) {
        var urlConstructor = URLComponents()
        urlConstructor.scheme = scheme
        urlConstructor.host = host
        urlConstructor.path = vkMethods.getNewsPosts.rawValue
        urlConstructor.queryItems = [
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "filters", value: "post"),
            URLQueryItem(name: "count", value: "5"),
            URLQueryItem(name: "v", value: "5.131")
        ]
        guard let url = urlConstructor.url else { return }
        
        let session = session
        
        let task = session.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                print("Ошибка получения новостей", error!.localizedDescription)
                completion(.failure(.serverError))
                return
            }
            guard let data = data else {
                completion(.failure(.noData))
                print("Не пришли данные новостей")
                return
            }
            do {

                let response = try JSONDecoder().decode(NewsPostRoot.self, from: data).response
                let items = response.items
                let groups = response.groups
                let profiles = response.profiles
                completion(.success((items, groups, profiles)))
            } catch {
                print("Ошибка декодирования новостей")
                print(error)
                completion(.failure(.decodeError))
            }
        }
        task.resume()
    }
    
    enum JSONError: Error {
        case decodeError
        case noData
        case serverError
        case savingToFileManagerError
    }
}
