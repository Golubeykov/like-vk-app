//
//  MyFriendViewController.swift
//  likeVKontakte
//
//  Created by Антон Голубейков on 24.06.2022.
//

import UIKit

class MyFriendViewController: UIViewController {

    @IBOutlet weak var friendPhotos: UICollectionView!
    @IBOutlet weak var friendAvatar: UIImageView!
    @IBOutlet weak var friendName: UILabel!
    
    var friend: Friend = Friend(name: "", imageName: "", photosLibrary: [])
    let reuseIdentifierFriendCell = "IdentifierFriendCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friendName.text = friend.name
        if let friendAvatarLoaded = UIImage(named: friend.imageName) {
            friendAvatar.image = friendAvatarLoaded
        }
        friendPhotos.dataSource = self
        friendPhotos.delegate = self
        friendPhotos.reloadData()
    }
}

extension MyFriendViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        friend.photosLibrary.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierFriendCell, for: indexPath) as! FriendCollectionViewCell
        if let friendPhotoLibraryItem = UIImage(named: friend.photosLibrary[indexPath.item]) {
        cell.friendPhotosCell.image = friendPhotoLibraryItem
        } else { cell.friendPhotosCell.image = UIImage(systemName: "multiply") }
        return cell
    }
}
//Delegate
extension MyFriendViewController: UICollectionViewDelegate {
    
    
}
extension MyFriendViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width / 2 - 10, height: collectionView.bounds.width / 2 - 10)
    }
}
