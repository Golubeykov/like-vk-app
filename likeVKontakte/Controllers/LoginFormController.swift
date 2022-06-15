//
//  LoginFormController.swift
//  likeVKontakte
//
//  Created by Антон Голубейков on 10.06.2022.
//

import UIKit

class LoginFormController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) { super.viewWillAppear(animated)
    // Подписываемся на два уведомления: одно приходит при появлении клавиатуры
    NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
    // Второе — когда она пропадает
    NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Жест нажатия
        let hideKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        // Присваиваем его UIScrollVIew
        scrollView?.addGestureRecognizer(hideKeyboardGesture)

    }
    //Отписываемся от центра уведомлений
    override func viewWillDisappear(_ animated: Bool) { super.viewWillDisappear(animated)
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // Скрытие клавиатуры
    @objc func hideKeyboard() { self.scrollView?.endEditing(true)
    }
    
    @IBOutlet weak var loginInput: UITextField!
    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        // Получаем текст логина
        let login = loginInput.text!
        // Получаем текст-пароль
        let password = passwordInput.text!
        // Проверяем, верны ли они
        if login == "admin" && password == "123456" { print("успешная авторизация")
        } else {
        print("неуспешная авторизация")
        }
    }
    // Когда клавиатура появляется
    @objc func keyboardWasShown(notification: Notification) {
            // Получаем размер клавиатуры
    let info = notification.userInfo! as NSDictionary
    let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
    let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
            // Добавляем отступ внизу UIScrollView, равный размеру клавиатуры
    self.scrollView?.contentInset = contentInsets
    scrollView?.scrollIndicatorInsets = contentInsets }
        //Когда клавиатура исчезает
    @objc func keyboardWillBeHidden(notification: Notification) { // Устанавливаем отступ внизу UIScrollView, равный 0
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
    }

}
