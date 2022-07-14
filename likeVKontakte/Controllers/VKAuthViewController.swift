//
//  VKAuthViewController.swift
//  likeVKontakte
//
//  Created by Антон Голубейков on 04.07.2022.
//

import UIKit
import WebKit
import SwiftUI
import RealmSwift

class VKAuthViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    
    // Константы для аутентификации vk
    private let appId = "8216359"
    private let scope = "262150" // права доступа
    private let version = "5.131"
    
    // Переменные для анимации
    @IBOutlet weak var loadView1: UIView!
    @IBOutlet weak var loadView2: UIView!
    @IBOutlet weak var loadView3: UIView!
    private let stackView: UIStackView = {
        $0.distribution = .fill
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = 10
        return $0
    }(UIStackView())
    private let circleA = UIView()
    private let circleB = UIView()
    private let circleC = UIView()
    private lazy var circles = [circleA, circleB, circleC]
    
    
    var friendsJSON: [FriendJSON] = []
    var groupsJSON: [Group] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        
        if let request = vkAuthRequest() {
            webView.load(request)
        }
        
        view.backgroundColor = .white
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        circles.forEach {
            $0.layer.cornerRadius = 20/2
            $0.layer.masksToBounds = true
            $0.backgroundColor = .systemBlue
            stackView.addArrangedSubview($0)
            $0.widthAnchor.constraint(equalToConstant: 20).isActive = true
            $0.heightAnchor.constraint(equalTo: $0.widthAnchor).isActive = true
        }
    }

    //MARK: - Аутентификация (шаг 1)
    func vkAuthRequest() -> URLRequest? {
         var urlComponents = URLComponents()
         urlComponents.scheme = "https"
         urlComponents.host = "oauth.vk.com"
         urlComponents.path = "/authorize"
         urlComponents.queryItems = [
             URLQueryItem(name: "client_id", value: appId),
             URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
             URLQueryItem(name: "response_type", value: "token"),
             URLQueryItem(name: "scope", value: scope),
             URLQueryItem(name: "v", value: version)
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
        self.animate()
         guard let url = navigationResponse.response.url,
               url.path == "/blank.html",
               let fragment = url.fragment else {
             //decisionHandler вызывается и здесь, и ниже, чтобы завершить исполнение функции
             decisionHandler(.allow)
             return
         }
        //self.loadAnimation()
        
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
             print(token)
             NetworkData.shared.addData(token: token, userID: user_id)
             
             //MARK: - вызовы сервисов (get friends, groups) (шаг 3)
             let VKService = VKService(token: token, user_id: user_id)
             VKService.getGroupsAF {
                 self.doFriendsRequest(token: token,user_id: user_id)
             }
            //Костыль? По-хорошему бы вынести doFriendRequest в NetworkService, но performSegue держит его здесь
            //performSegue(withIdentifier: "VKAuthSuccess", sender: self)
         }
        decisionHandler(.cancel)
     }
 }

extension VKAuthViewController {
    //MARK: - вызовы сервисов (get friends, groups) (шаг 3)
    func doFriendsRequest(token: String, user_id: String) {
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
                print("Случилась ошибка в отгрузке друзей")
                //Костыль?
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "VKAuthSuccess", sender: self)
                }
            }
        }
     }
}
// Анимация загрузки (вариант 1 - потухающие квадратики)
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

extension VKAuthViewController {

// Анимация (вариант 2 - с прыгающими шарами)
    func animate() {
        let jumpDuration: Double = 0.30
        let delayDuration: Double = 1.25
        let totalDuration: Double = delayDuration + jumpDuration*2

        let jumpRelativeDuration: Double = jumpDuration / totalDuration
        let jumpRelativeTime: Double = delayDuration / totalDuration
        let fallRelativeTime: Double = (delayDuration + jumpDuration) / totalDuration

        for (index, circle) in circles.enumerated() {
            let delay = jumpDuration*2 * TimeInterval(index) / TimeInterval(circles.count)
            UIView.animateKeyframes(withDuration: totalDuration, delay: delay, options: [.repeat], animations: {
                UIView.addKeyframe(withRelativeStartTime: jumpRelativeTime, relativeDuration: jumpRelativeDuration) {
                    circle.frame.origin.y -= 30
                }
                UIView.addKeyframe(withRelativeStartTime: fallRelativeTime, relativeDuration: jumpRelativeDuration) {
                    circle.frame.origin.y += 30
                }
            })
        }
    }
}
