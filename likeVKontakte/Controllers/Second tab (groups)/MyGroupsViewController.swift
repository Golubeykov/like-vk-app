//
//  MyGroupsViewController.swift
//  likeVKontakte
//
//  Created by Антон Голубейков on 24.06.2022.
//

import UIKit

class MyGroupsViewController: UIViewController {

    @IBOutlet weak var myGroupsTableView: UITableView!

    var myGroups = MyGroupsStorage.shared.getMyGroups()
    // просто сохраняем идшник
    let reuseIdGroupList = GroupListTableViewCell.reuseIdGroupListTableViewCell
    let fromMyToAllGroups = "fromMyToAllGroups"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myGroupsTableView.dataSource = self
        myGroupsTableView.delegate = self
        //Регистрируем ячейку из xib-файла
        myGroupsTableView.register(UINib(nibName: reuseIdGroupList, bundle: nil), forCellReuseIdentifier: reuseIdGroupList)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        myGroups = MyGroupsStorage.shared.getMyGroups()
        self.myGroupsTableView.reloadData()
    }
    @IBAction func addGroups(_ sender: Any) {
        performSegue(withIdentifier: "fromMyToAllGroups", sender: nil)
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
    //Удаление ячейки
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        myGroups.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .top)
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

