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
    //MARK: - Переход на страницу друга
//    @IBAction func friendDetail(segue: UIStoryboardSegue) {
//        guard let friendVC = segue.destination as? FriendViewController, let friendIndex = self.tableView.indexPathForSelectedRow else { return }
//        friendVC.friendImage.image = self.tableView.cellForRow(at: friendIndex)?.imageView?.image ?? UIImage(named: "Stepan")
//    }
    
    // устанавливаем действие при выделении ячейки
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    // выполняем переход. в качестве sender-аргумента советую отправить IndexPath ячейки, откуда отправляете
//        //performSegue(withIdentifier: "friendDetail", sender: indexPath)
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard segue.identifier == "friendDetail", let friendVC = segue.destination as? FriendViewController, let friendIndex = self.tableView.indexPathForSelectedRow else { return }
//        friendVC.friendImage = self.tableView.cellForRow(at: friendIndex)?. ?? UIImage(named: "Stepan")
//    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let vc = storyboard?.instantiateViewController(withIdentifier: "FriendViewController") as? FriendViewController
           let friend = testFriends[indexPath.row].name
           vc?.friendImage = UIImage(named: friend)!
           navigationController?.pushViewController(vc!, animated: true)
    }
}
