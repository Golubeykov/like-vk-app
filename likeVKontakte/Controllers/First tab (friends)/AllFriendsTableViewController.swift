//
//  MyFriendsTableViewController.swift
//  likeVKontakte
//
//  Created by Антон Голубейков on 19.06.2022.
//

import UIKit

class AllFriendsTableViewController: UITableViewController {
    @IBAction func pullRefresh(_ sender: Any) {
        DispatchQueue.main.async {
            self.testFriends = MyFriendsStorage.shared.getMyFriends()
            self.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        }
    }
    private var testFriends = MyFriendsStorage.shared.getMyFriends()
    
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
        if let imageHardCode = UIImage(named: imageName) {
            cell.friendImage.image = imageHardCode
        } else if let friendAvatarInternetLoaded = UIImage(data: try! Data(contentsOf: URL(string: "https://i.pinimg.com/originals/fc/8d/e5/fc8de58425df53feda5959e0c868cf0b.jpg")!))
        {
            cell.friendImage.image = friendAvatarInternetLoaded
        } else {
            cell.friendImage.image = UIImage(named: "Stepan")
        }
            
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
