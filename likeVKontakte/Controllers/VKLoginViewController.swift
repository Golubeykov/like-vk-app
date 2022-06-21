//
//  VKLoginViewController.swift
//  likeVKontakte
//
//  Created by Антон Голубейков on 20.06.2022.
//

import UIKit
import WebKit

class VKLoginViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
        
        if let request = vkAuthRequest() {
            webView.load(request)
        }
    }
//MARK: - Шаг 3 вызов getFriends
    func doNetworkRequest(token: String, user_id: String) {
        let service = VKService(token: token, user_id: user_id)
        service.getFriends()
        service.getFriendsAF()
    }
//MARK: - Шаг 1 аутентификация
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
//MARK: - Шаг 2 запись токена и user_id
extension VKLoginViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Swift.Void) {
        
        guard let url = navigationResponse.response.url,
              url.path == "/blank.html",
              let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
        
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
            doNetworkRequest(token: token,user_id: user_id)
            
            print(token)
            print(user_id)
            performSegue(withIdentifier: "VKloginsuccess", sender: self)
            decisionHandler(.cancel)
        }
//        decisionHandler(.allow)
//        decisionHandler(.cancel)
//        performSegue(withIdentifier: "VKloginsuccess", sender: self)
    }
}
