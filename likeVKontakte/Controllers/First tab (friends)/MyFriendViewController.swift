//
//  MyFriendViewController.swift
//  likeVKontakte
//
//  Created by Антон Голубейков on 24.06.2022.
//

import UIKit

class MyFriendViewController: UIViewController {

    @IBOutlet weak var playStopButtonLabel: UIBarButtonItem!
    @IBOutlet weak var friendPhotos: UICollectionView!
    @IBOutlet weak var friendAvatarView: UIView!
    @IBOutlet weak var friendAvatar: UIImageView!
    @IBOutlet weak var friendName: UILabel!
    //Прокрутить аватарку друга
    @IBAction func spinFriend(_ sender: UIBarButtonItem) {
        isRotating = !isRotating
        print(isRotating)
        if isRotating {
            playStopButtonLabel.image = UIImage(systemName: "stop.fill")
            self.rotateView(targetView: friendAvatarView, duration: 0.5)
        } else {
            playStopButtonLabel.image = UIImage(systemName: "play.fill")
            self.friendAvatarView.layer.removeAllAnimations()
        }
    }
    
    var friend: Friend = Friend(name: "", imageName: "", photosLibrary: [])
    var filteredPhotos: [String] { friend.photosLibrary.filter { UIImage(named: $0) != nil } }
    let reuseIdentifierFriendCell = "IdentifierFriendCell"
    var isRotating = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friendAvatar.layer.masksToBounds = true
        //friendAvatar.layer.cornerRadius = friendAvatar.bounds.height/2
        friendAvatar.applyshadowWithCorner(containerView: friendAvatarView, cornerRadious: friendAvatar.bounds.height/2)
        friendName.text = friend.name
        if let friendAvatarLoaded = UIImage(named: friend.imageName) {
            friendAvatar.image = friendAvatarLoaded
        }
        friendPhotos.dataSource = self
        friendPhotos.delegate = self
        friendPhotos.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateFriendAvatar()
    }
    //Прокрутить аватарку друга
    private func rotateView(targetView: UIView, duration: Double = 0.5) {
       UIView.animate(withDuration: duration, delay: 0.0, options: .curveLinear, animations: {
           targetView.transform = targetView.transform.rotated(by: .pi/10)
       }) { finished in
           if self.isRotating {
           print(duration)
           self.rotateView(targetView: targetView, duration: duration)
           }
       }
   }
    //Пружинная анимация аватарки друга
    func animateFriendAvatar () {
        let aSelector: Selector = #selector(animateAvatar)
        let tapGesture = UITapGestureRecognizer(target:self, action: aSelector)
        friendAvatarView.addGestureRecognizer(tapGesture)
    }
    
    @objc func animateAvatar() {
        let springAnimate = CASpringAnimation(keyPath: "transform.scale")
        springAnimate.fromValue = 0.9
        springAnimate.toValue = 1
        springAnimate.duration = 1
        springAnimate.stiffness = 300
        springAnimate.mass = 2
        self.friendAvatarView.layer.add(springAnimate, forKey: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? HorizontalGalleryViewController {
            vc.filteredPhotos = self.filteredPhotos
        }
    }
    
}


extension MyFriendViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filteredPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierFriendCell, for: indexPath) as! FriendCollectionViewCell
        if let friendPhotoLibraryItem = UIImage(named: filteredPhotos[indexPath.item]) {
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

extension UIImageView {
    func applyshadowWithCorner(containerView : UIView, cornerRadious : CGFloat){
        containerView.clipsToBounds = false
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 1
        containerView.layer.shadowOffset = CGSize(width: 3, height: 3)
        containerView.layer.shadowRadius = 3
        containerView.layer.cornerRadius = cornerRadious
        containerView.layer.shadowPath = UIBezierPath(roundedRect: containerView.bounds, cornerRadius: cornerRadious).cgPath
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadious
    }
}
