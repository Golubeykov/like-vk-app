//
//  AllGroupsViewController.swift
//  likeVKontakte
//
//  Created by Антон Голубейков on 24.06.2022.
//

import UIKit

class AllGroupsViewController: UIViewController {
    
    @IBOutlet weak var allGroupsTableView: UITableView!
    
    var allGroups = Group.testGroups
    // просто сохраняем идшник
    let reuseIdGroupList = GroupListTableViewCell.reuseIdGroupListTableViewCell
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allGroupsTableView.dataSource = self
        allGroupsTableView.delegate = self
        //Регистрируем ячейку из xib-файла
        allGroupsTableView.register(UINib(nibName: reuseIdGroupList, bundle: nil), forCellReuseIdentifier: reuseIdGroupList)
    }
    override func viewDidAppear(_ animated: Bool) {
        print("all groups")
    }
}
//Data source
extension AllGroupsViewController: UITableViewDataSource {
    // Количество строк в секции
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allGroups.count
    }

    // Формирование ячейки строки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdGroupList, for: indexPath) as? GroupListTableViewCell else { return UITableViewCell() }
        cell.configure(group: allGroups[indexPath.row])
        return cell
    }
}
//Delegate
extension AllGroupsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected \(allGroups[indexPath.row].name) group")
        MyGroupsStorage.shared.addGroup(group: allGroups[indexPath.row])
        navigationController?.popViewController(animated: true)
    }
    
}

