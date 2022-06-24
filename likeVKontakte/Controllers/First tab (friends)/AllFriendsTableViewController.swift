//
//  MyFriendsTableViewController.swift
//  likeVKontakte
//
//  Created by Антон Голубейков on 19.06.2022.
//

import UIKit

class AllFriendsTableViewController: UITableViewController {
    
    private let testFriends: [Friend] = [
    Friend(name: "Лёлик", imageName: "Lelik", photosLibrary: ["meow", "kus", "catLogo","fish"]),
    Friend(name: "Миса", imageName: "Misa", photosLibrary: ["kus", "tsarap", "fish","Stepan"]),
    Friend(name: "Степан", imageName: "Stepan", photosLibrary: ["test", "kus", "tsarap","meow"])
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

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "MyFriendViewController") as? MyFriendViewController else {return}
           let friend = testFriends[indexPath.row]
            vc.friend = friend
           navigationController?.pushViewController(vc, animated: true)
    }
}
