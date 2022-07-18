//
//  PostLikesCell.swift
//  likeVKontakte
//
//  Created by Антон Голубейков on 14.07.2022.
//

import UIKit

class PostLikesCell: UITableViewCell {

    @IBOutlet weak var numberOfLikes: UILabel!
    
    func configureCell(post: NewsPost) {
        numberOfLikes.text = String(post.numberOfLikes)
    }
}
