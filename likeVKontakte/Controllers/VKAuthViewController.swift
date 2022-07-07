//
//  VKAuthViewController.swift
//  likeVKontakte
//
//  Created by Антон Голубейков on 04.07.2022.
//

import UIKit
import WebKit
import SwiftUI

class VKAuthViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var loadView1: UIView!
    @IBOutlet weak var loadView2: UIView!
    @IBOutlet weak var loadView3: UIView!
    
    var friendsJSON: [FriendJSON] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        
        if let request = vkAuthRequest() {
            webView.load(request)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }
    //MARK: - Аутентификация (шаг 1)
    func vkAuthRequest() -> URLRequest? {
         var urlComponents = URLComponents()
         urlComponents.scheme = "https"
         urlComponents.host = "oauth.vk.com"
         urlComponents.path = "/authorize"
         urlComponents.queryItems = [
             URLQueryItem(name: "client_id", value: "8199321"),
             URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
             URLQueryItem(name: "response_type", value: "token"),
             URLQueryItem(name: "scope", value: "262150"),
             URLQueryItem(name: "v", value: "5.131")
         ]

         if let url = urlComponents.url {
             return URLRequest(url: url)
         }

         return nil
     }
}

//MARK: - Запись токена и user_id (шаг 2)
extension VKAuthViewController: WKNavigationDelegate {
    //Нужно, чтобы отловить момент успешной аутентификации (когда пойдет редирект на blank.html)
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Swift.Void) {
         guard let url = navigationResponse.response.url,
               url.path == "/blank.html",
               let fragment = url.fragment else {
             //decisionHandler вызывается и здесь, и ниже, чтобы завершить исполнение функции
             decisionHandler(.allow)
             return
         }
        self.loadAnimation()
         let params = fragment
             .components(separatedBy: "&")
             .map({ $0.components(separatedBy: "=") })
             .reduce([String: String]()) { result, param in
                 var dict = result
                 let key = param[0]
                 let value = param[1]
                 dict[key] = value
                 return dict
             }

         if let token = params["access_token"], let user_id = params["user_id"] {
             self.doNetworkRequest(token: token,user_id: user_id)
            //Костыль?
            //performSegue(withIdentifier: "VKAuthSuccess", sender: self)
         }
        decisionHandler(.cancel)
     }
 }

extension VKAuthViewController {
    //MARK: - вызовы сервисов (get friends, groups) (шаг 3)
    func doNetworkRequest(token: String, user_id: String) {
        let service = VKService(token: token, user_id: user_id)
        service.getFriends { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let friends):
                self.friendsJSON = friends
                print(self.friendsJSON[0].imageURL)
                for friend in friends {
                    let newFriend: Friend = Friend(id: String(friend.id), name: friend.name, imageName: friend.imageURL, photosLibrary: [])
                    MyFriendsStorage.shared.addFriend(friend: newFriend)
                }
                //Костыль?
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "VKAuthSuccess", sender: self)
                }
            case .failure:
                print("Случилась ошибка")
                //Костыль?
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "VKAuthSuccess", sender: self)
                }
            }
        }
     }
}
// Анимация загрузки
extension VKAuthViewController {
    func loadAnimation() {
        self.loadView1.backgroundColor = .blue
        self.loadView2.backgroundColor = .blue
        self.loadView3.backgroundColor = .blue
        UIView.animate(withDuration: 0.9, delay: 0, options: [.autoreverse], animations: {
            self.loadView1.alpha = 0
        })
        UIView.animate(withDuration: 0.9, delay: 0.3, options: [.autoreverse], animations: {
            self.loadView2.alpha = 0
        })
        UIView.animate(withDuration: 0.9, delay: 0.6, options: [.autoreverse], animations: {
            self.loadView3.alpha = 0
        })
    }
}
