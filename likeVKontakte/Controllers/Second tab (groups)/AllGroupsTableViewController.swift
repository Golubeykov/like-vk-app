//
//  AllGroupsTableViewController.swift
//  likeVKontakte
//
//  Created by Антон Голубейков on 19.06.2022.
//

import UIKit

class AllGroupsTableViewController: UITableViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    var allGroups: [Group] = Group.testGroups
    
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
        cell.setup(with: group)
        
        return cell
    }
}

//MARK: - Реализация поиска

extension AllGroupsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        allGroups = Group.testGroups
        guard !searchText.isEmpty else {
            allGroups = Group.testGroups
            tableView.reloadData()
            return
        }
        allGroups = allGroups.filter { (group) -> Bool in
            group.name.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
}
