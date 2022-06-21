//
//  FriendViewController.swift
//  likeVKontakte
//
//  Created by Антон Голубейков on 20.06.2022.
//

import UIKit

class FriendViewController: UIViewController {
    
    var friendImage = UIImage()
    
    @IBOutlet weak var friendImageView: UIImageView!
    @IBOutlet weak var networkCall: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        friendImageView.image = friendImage
    }

}
