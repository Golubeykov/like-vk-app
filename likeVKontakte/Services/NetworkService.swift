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
    //MARK: - getFriends URL Session подгружаем json и парсим сразу
    func getFriends(completion: @escaping (Result<[FriendJSON], JSONError>) -> Void) {
        
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/friends.get"
        urlConstructor.queryItems = [
            //URLQueryItem(name: "lang", value: "en"),
            URLQueryItem(name: "user_id", value: user_id),
            URLQueryItem(name: "order_id", value: "name"),
            URLQueryItem(name: "count", value: "5"),
            URLQueryItem(name: "fields", value: "city, country, photo_200, universities"),
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
    
    //MARK: - getFriendPhotos Сохраняем json в FileStorage после загрузки
    func getFriendsPhotos(for friend: Friend, completion: @escaping (Result<URL, JSONError>) -> Void) {
        
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
        
        let session = URLSession(configuration: .default)
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
    
    //MARK: - Alamofire getGroups
    func getGroupsAF(completion: @escaping (Result<[Group], JSONError>) -> Void) {
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/groups.get"
        urlConstructor.queryItems = [
            URLQueryItem(name: "user_id", value: user_id),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "fields", value: "members_count"),
            URLQueryItem(name: "count", value: "7"),
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "v", value: "5.131")
        ]
        guard let url = urlConstructor.url else { return }
        
        AF.request(url).responseJSON { (response) in
            if let error = response.error {
                completion(.failure(.serverError))
                print(error)
            }
            guard let data = response.data else {
                completion(.failure(.noData))
                return
            }
            do {
                let groups = try JSONDecoder().decode(RootGroupJSON.self, from: data).response.items
                self.saveGroupsInRealm(groups)
                completion(.success(groups))
            } catch {
                print("Ошибка декодирования")
                print(error)
                completion(.failure(.decodeError))
            }
        }
    }
    
    func doGroupsRequest(token: String, user_id: String) {
        self.getGroupsAF { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let groups):
                for group in groups {
                    AllGroupsStorage.shared.addGroup(group: group)
                }
            case .failure:
                print("Случилась ошибка в отгрузке групп")
            }
        }
    }
    
    func saveGroupsInRealm (_ groups: [Group]) {
        // На бою так не делаем, чтобы не положить базу)) Это чисто для теста
        Realm.Configuration.defaultConfiguration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
        do {
            let realm = try Realm()
            let networkGroupsFiltered = realm.objects(Group.self).filter("name BEGINSWITH 'B'")
            print("Filtered groups in Realm:", networkGroupsFiltered.count)
            print("Realm file path:", realm.configuration.fileURL ?? "No Realm path")
            realm.beginWrite()
            let oldGroupsList = realm.objects(Group.self)
            realm.delete(oldGroupsList)
            realm.add(groups)
            try realm.commitWrite()

        } catch {
            print(error)
            print("Ошибка сохранения данных в Realm")
        }
    }
    
    
    enum JSONError: Error {
        case decodeError
        case noData
        case serverError
        case savingToFileManagerError
    }
}
