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
    
    func configureCell(post: NewsPost) {
        if let photoLocal = UIImage(named: post.titlePhoto) {
            titlePhoto.image = photoLocal
        } else if let photoInternetLoaded = UIImage(data: {
            do {
                guard let url = URL(string: post.titlePhoto) else { return Data() }
                let data = try Data(contentsOf: url)
                return data
        } catch {
            print("нет такого url")
            print(post.titlePhoto)
            return Data()
        }
        }()
        )
        {
            titlePhoto.image = photoInternetLoaded
        }
        
        titleName.text = post.titleName
        titlePhoto.layer.cornerRadius = titlePhoto.frame.width/2
        titlePhoto.clipsToBounds = true
    }
    
}
