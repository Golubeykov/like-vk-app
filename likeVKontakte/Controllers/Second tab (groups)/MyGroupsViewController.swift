//
//  MyGroupsViewController.swift
//  likeVKontakte
//
//  Created by Антон Голубейков on 24.06.2022.
//

import UIKit

class MyGroupsViewController: UIViewController {

    @IBOutlet weak var myGroupsTableView: UITableView!
    var myGroups = Group.testGroups
    // просто сохраняем идшник
    let reuseIdGroupList = GroupListTableViewCell.reuseIdGroupListTableViewCell
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myGroupsTableView.dataSource = self
        myGroupsTableView.delegate = self
        //Регистрируем ячейку из xib-файла
        myGroupsTableView.register(UINib(nibName: reuseIdGroupList, bundle: nil), forCellReuseIdentifier: reuseIdGroupList)
    }
}
//Data source
extension MyGroupsViewController: UITableViewDataSource {
    // Количество строк в секции
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myGroups.count
    }

    // Формирование ячейки строки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdGroupList, for: indexPath) as? GroupListTableViewCell else { return UITableViewCell() }
        cell.configure(group: myGroups[indexPath.row])
        return cell
    }
}
//Delegate
extension MyGroupsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected \(myGroups[indexPath.row].name) group")
    }
    
}

