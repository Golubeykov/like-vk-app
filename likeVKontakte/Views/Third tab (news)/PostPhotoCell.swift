//
//  PostPhotoCell.swift
//  likeVKontakte
//
//  Created by Антон Голубейков on 14.07.2022.
//

import UIKit

class PostPhotoCell: UITableViewCell {

    @IBOutlet weak var bodyPhoto: UIImageView!
    
    func configureCell(post: NewsPost) {
        bodyPhoto.image = UIImage(named: post.bodyPhoto)
    }

}
