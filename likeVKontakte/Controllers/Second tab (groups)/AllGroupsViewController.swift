//
//  AllGroupsViewController.swift
//  likeVKontakte
//
//  Created by Антон Голубейков on 24.06.2022.
//

import UIKit
import RealmSwift

class AllGroupsViewController: UIViewController {
    
    @IBOutlet weak var allGroupsTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //var allGroups: [Group] = AllGroupsStorage.shared.getAllGroups()
    //var groupsFiltered: [Group] = AllGroupsStorage.shared.getAllGroups()
    let refreshControl = UIRefreshControl()
    
    //Токен для нотификаций Realm
    var token: NotificationToken?
    var groupsFromRealm: Results<Group>?
    var allGroups: Results<Group>?
    var groupsCount: Int?
    
    // просто сохраняем идшник
    let reuseIdGroupList = GroupListTableViewCell.reuseIdGroupListTableViewCell
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allGroupsTableView.dataSource = self
        allGroupsTableView.delegate = self
        searchBar.delegate = self
        
        //Регистрируем ячейку из xib-файла
        allGroupsTableView.register(UINib(nibName: reuseIdGroupList, bundle: nil), forCellReuseIdentifier: reuseIdGroupList)
        DispatchQueue.main.async {
            self.pairTableAndRealm()
        }
        
        //Pull to refresh control
        refreshControl.attributedTitle = NSAttributedString(string: "Загрузка данных")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        allGroupsTableView.addSubview(refreshControl)
        
    }
    //Pull to refresh (данные подгружаются из интернета)
    @objc func refresh(_ sender: AnyObject) {
        let token = NetworkData.shared.getToken()
        let user_id = NetworkData.shared.getLoggedUserId()
        let VKService = VKService(token: token, user_id: user_id)
        
        VKService.getGroupsAF {
            self.pairTableAndRealm()
            self.refreshControl.endRefreshing()
            }
        self.refreshControl.endRefreshing()
        }
}
//TableView Data source
extension AllGroupsViewController: UITableViewDataSource {
    //Количество секций
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Количество строк в секции
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsCount ?? 0
    }
    
    // Формирование ячейки строки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdGroupList, for: indexPath) as? GroupListTableViewCell else { return UITableViewCell() }
        guard let group = groupsFromRealm?[save: indexPath.row] else { return UITableViewCell() }
        if indexPath.row < groupsCount! {
            cell.configure(group: group)
            return cell
        } else {
            return UITableViewCell()
        }
//        cell.configure(group: group)
//        return cell
    }
}
//TableView Delegate
extension AllGroupsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard (groupsFromRealm?[indexPath.row]) != nil else { return }
        print("selected \(groupsFromRealm![indexPath.row].name) group")
        MyGroupsStorage.shared.addGroup(group: groupsFromRealm![indexPath.row])
        navigationController?.popViewController(animated: true)
    }
}

//Search bar
extension AllGroupsViewController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        let groupsFromRealmTemp = groupsFromRealm
//        groupsFromRealm = allGroups
//        if !searchText.isEmpty {
//            //groupsFromRealm = groupsFromRealm?.filter ({ $0.name.lowercased().contains(searchText.lowercased()) })
//            //groupsFromRealm = groupsFromRealm?.filter("name == '%@'",searchText)
//        } else {
//            groupsFromRealm = groupsFromRealmTemp
//        }
//        allGroupsTableView.reloadData()
//    }
}

extension AllGroupsViewController {
    private func pairTableAndRealm() {
        guard let realm = try? Realm() else { return }
        realm.autorefresh = true
        groupsFromRealm = realm.objects(Group.self)
        guard let groupsFromRealm = groupsFromRealm else { return }
        groupsCount = groupsFromRealm.count
        token = groupsFromRealm.observe { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.allGroupsTableView else { return }
            switch changes {
            case .initial:
                tableView.reloadData()
            case .update(_, _, _, _):
                self?.groupsCount = groupsFromRealm.count
                //tableView.beginUpdates()
                tableView.reloadData()
//                tableView.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
//                tableView.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
//                tableView.reloadRows(at: modifications.map({IndexPath(row: $0, section: 0)}), with: .automatic)
                //tableView.endUpdates()
            case .error(let error):
                print(error)
            }
        }
    }
}

extension Results {
    subscript (save index: Int) -> Element? {
        if index < self.count {
            return self[index]
        } else {
            return nil
        }
    }
}


