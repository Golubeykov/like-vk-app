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
        
        if let photoLocal = UIImage(named: post.bodyPhoto) {
            bodyPhoto.image = photoLocal
        } else if let photoInternetLoaded = UIImage(data: {
            do {
                guard let url = URL(string: post.bodyPhoto) else { return Data() }
                let data = try Data(contentsOf: url)
                return data
        } catch {
            print("нет такого url")
            print(post.bodyPhoto)
            return Data()
        }
        }()
        )
        {
            bodyPhoto.image = photoInternetLoaded
        }
    }
}
