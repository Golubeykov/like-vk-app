//
//  HorizontalGalleryControllerViewController.swift
//  likeVKontakte
//
//  Created by Антон Голубейков on 30.06.2022.
//

import UIKit

class HorizontalGalleryViewController: UIViewController {

    @IBOutlet weak var horizontalGalleryView: HorizontalGalleryView!
    var filteredPhotos: [String] = []
    
    override func viewDidLoad() {
        var photos: [UIImage] = []
        for photoName in filteredPhotos {
            if let photo = UIImage(named: photoName) {
                photos.append(photo)
            }
        }
        super.viewDidLoad()
        print(filteredPhotos)
        horizontalGalleryView.setImages(images: photos)
    }

}
