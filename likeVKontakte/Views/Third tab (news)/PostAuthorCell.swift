//
//  PostAuthorCell.swift
//  likeVKontakte
//
//  Created by Антон Голубейков on 14.07.2022.
//

import UIKit

class PostAuthorCell: UITableViewCell {

    @IBOutlet weak var titlePhoto: UIImageView!
    @IBOutlet weak var titleName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(post: NewsPost) {
        titlePhoto.image = UIImage(named: post.titlePhoto)
        titleName.text = post.titleName
        titlePhoto.layer.cornerRadius = titlePhoto.frame.width/2
        titlePhoto.clipsToBounds = true
    }
    
}
