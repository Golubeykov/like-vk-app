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
            } else if let friendPhotosInternetLoaded = UIImage(data: {
                do { let data = try Data(contentsOf: URL(string: photoName)!)
                    return data
                } catch {
                    print("нет такого url")
                    print(photoName)
                    return Data()
                }
            }()
            ) {
                photos.append(friendPhotosInternetLoaded)
            }
        }
        super.viewDidLoad()
        print(filteredPhotos)
        horizontalGalleryView.setImages(images: photos)
    }

}
