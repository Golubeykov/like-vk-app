//
//  MyFriendsTableViewController.swift
//  likeVKontakte
//
//  Created by Антон Голубейков on 19.06.2022.
//

import UIKit

class AllFriendsTableViewController: UITableViewController {
    
    private let testFriends: [Friend] = [
    Friend(name: "Лёлик", imageName: "Lelik"),
    Friend(name: "Миса", imageName: "Misa"),
    Friend(name: "Степан", imageName: "Stepan")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Постоение ячеек
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testFriends.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsListCell", for: indexPath) as! FriendsListTableViewCell
        let friend = testFriends[indexPath.row]
        cell.friendNameLabel.text = friend.name
        
        let imageName = "\(friend.imageName)"
        cell.friendImage.image = UIImage(named: imageName)
            
        return cell
    }
    //MARK: - Переход на страницу друга

//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//           let vc = storyboard?.instantiateViewController(withIdentifier: "FriendViewController") as? FriendViewController
//           let friend = testFriends[indexPath.row].name
//           vc?.friendImage = UIImage(named: friend)!
//           navigationController?.pushViewController(vc!, animated: true)
//    }
}
