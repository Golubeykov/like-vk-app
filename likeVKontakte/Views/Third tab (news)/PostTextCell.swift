//
//  PostTextCell.swift
//  likeVKontakte
//
//  Created by Антон Голубейков on 14.07.2022.
//

import UIKit

class PostTextCell: UITableViewCell {

    @IBOutlet weak var bodyText: UILabel!
    
    func configureCell(post: NewsPost) {
        bodyText.text = post.bodyText
    }
    
}
