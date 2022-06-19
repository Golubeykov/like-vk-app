//
//  AllGroupsTableViewController.swift
//  likeVKontakte
//
//  Created by Антон Голубейков on 19.06.2022.
//

import UIKit
// 1 47
class AllGroupsTableViewController: UITableViewController {
    var allGroups: [Group] = [
    Group(name: "Kus", logoName: "Kus", numberOfParticipants: 4_142),
    Group(name: "Tsarap", logoName: "Tsatap", numberOfParticipants: 1_630),
    Group(name: "Meow", logoName: "Meow", numberOfParticipants: 743_882)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Постоение ячеек
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsCell", for: indexPath) as! GroupsListTableViewCell
        let group = allGroups[indexPath.row]
        cell.groupName.text = group.name
        cell.numberOfParticipants.text = String(group.numberOfParticipants)
        
        return cell
    }
}
