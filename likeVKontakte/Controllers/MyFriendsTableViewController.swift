//
//  MyFriendsTableViewController.swift
//  likeVKontakte
//
//  Created by Антон Голубейков on 19.06.2022.
//

import UIKit

class MyFriendsTableViewController: UITableViewController {
    
    private let testFriends: [Friend] = [
    Friend(name: "Lelik", imageName: "Lelik"),
    Friend(name: "Misa", imageName: "Misa"),
    Friend(name: "Stepan", imageName: "Stepan")
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
        
        let imageName = "\(friend.name)"
        cell.friendImage.image = UIImage(named: imageName)
            
        return cell
    }
    
}
