//
//  MyGroupsTableViewController.swift
//  likeVKontakte
//
//  Created by Антон Голубейков on 19.06.2022.
//

import UIKit

class MyGroupsTableViewController: UITableViewController {

    var myGroups: [Group] = []
    let networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //networkService.loadWeatherData()
        networkService.loadWeatherWithAlamo()
    }
//MARK: - Постоение ячеек
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsCell", for: indexPath) as! GroupsListTableViewCell
        let group = myGroups[indexPath.row]
        cell.setup(with: group)
        
        return cell
    }
//MARK: - Добаление групп в "Мои группы"
    @IBAction func addGroup(segue: UIStoryboardSegue) {
        guard let allGroupsVC = segue.source as? AllGroupsTableViewController, let groupIndex = allGroupsVC.tableView.indexPathForSelectedRow else { return print("Got nil") }
        let currentGroup = allGroupsVC.allGroups[groupIndex.row]
        
        if !myGroups.contains(where: { $0 == currentGroup}) {
        myGroups.append(currentGroup)
        self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            myGroups.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
    }
}

    

