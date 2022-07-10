//
//  AllGroupsViewController.swift
//  likeVKontakte
//
//  Created by Антон Голубейков on 24.06.2022.
//

import UIKit

class AllGroupsViewController: UIViewController {
    
    @IBOutlet weak var allGroupsTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var allGroups: [Group] = AllGroupsStorage.shared.getAllGroups()
    var groupsFiltered: [Group] = AllGroupsStorage.shared.getAllGroups()
    let refreshControl = UIRefreshControl()
    
    // просто сохраняем идшник
    let reuseIdGroupList = GroupListTableViewCell.reuseIdGroupListTableViewCell
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allGroupsTableView.dataSource = self
        allGroupsTableView.delegate = self
        searchBar.delegate = self
        //Регистрируем ячейку из xib-файла
        allGroupsTableView.register(UINib(nibName: reuseIdGroupList, bundle: nil), forCellReuseIdentifier: reuseIdGroupList)
        refreshControl.attributedTitle = NSAttributedString(string: "Загрузка данных")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        allGroupsTableView.addSubview(refreshControl)
    }
    @objc func refresh(_ sender: AnyObject) {
        DispatchQueue.main.async {
            let vkAuth = VKAuthViewController()
            let token = NetworkData.shared.getToken()
            let user_id = NetworkData.shared.getLoggedUserId()

            let VKService = VKService(token: token, user_id: user_id)
            VKService.doGroupsRequest(token: token, user_id: user_id)
            
            self.refreshControl.endRefreshing()
            self.groupsFiltered = []
            self.groupsFiltered = AllGroupsStorage.shared.getAllGroups()
            self.allGroupsTableView.reloadData()
        }
    }

    
}
//TableView Data source
extension AllGroupsViewController: UITableViewDataSource {
    // Количество строк в секции
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsFiltered.count
    }

    // Формирование ячейки строки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdGroupList, for: indexPath) as? GroupListTableViewCell else { return UITableViewCell() }
        cell.configure(group: groupsFiltered[indexPath.row])
        return cell
    }
}
//TableView Delegate
extension AllGroupsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected \(groupsFiltered[indexPath.row].name) group")
        MyGroupsStorage.shared.addGroup(group: groupsFiltered[indexPath.row])
        navigationController?.popViewController(animated: true)
    }
    
}

//Search bar
extension AllGroupsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        groupsFiltered = allGroups
        if !searchText.isEmpty {
            groupsFiltered = groupsFiltered.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        } else {
            groupsFiltered = allGroups
        }
        allGroupsTableView.reloadData()
    }
}



