//
//  PostPhotoCell.swift
//  likeVKontakte
//
//  Created by Антон Голубейков on 14.07.2022.
//

import UIKit

class PostPhotoCell: UITableViewCell {

    @IBOutlet weak var bodyPhoto: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configureCell(post: NewsPost) {
        bodyPhoto.image = UIImage(named: post.bodyPhoto)
    }

}
