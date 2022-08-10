//
//  NewsViewController.swift
//  likeVKontakte
//
//  Created by Антон Голубейков on 14.07.2022.
//

import UIKit

class NewsViewController: UIViewController {
    
    //let testNews = NewsPost.testPosts
    var testNews = MyNewsPosts.shared.getMyNewsPosts()
    
    @IBOutlet weak var newsTableView: UITableView!
    
    let reuseIdPostAuthorCell = "PostAuthorCell"
    let reuseIdPostTextCell = "PostTextCell"
    let reuseIdPostPhotoCell = "PostPhotoCell"
    let reuseIdPostLikesCell = "PostLikesCell"
    let reuseSeparatorCell = "SeparatorCell"
    
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.delegate = self
        newsTableView.dataSource = self
        //Pull to refresh control
        refreshControl.attributedTitle = NSAttributedString(string: "Загрузка данных")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        newsTableView.addSubview(refreshControl)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        newsTableView.reloadData()
        testNews = MyNewsPosts.shared.getMyNewsPosts()
        print(testNews.count)
    }
    //Pull to refresh (обновить данные в таблице)
    @objc func refresh(_ sender: AnyObject) {
        self.newsTableView.reloadData()
        self.refreshControl.endRefreshing()
    }
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        testNews.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseSeparatorCell, for: indexPath) as? SeparatorCell else { return UITableViewCell() }
            cell.configure()
            return cell
        }
        else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdPostAuthorCell, for: indexPath) as? PostAuthorCell else { return UITableViewCell() }
            
            cell.configureCell(post: testNews[indexPath.section])
            return cell
        }
        else if indexPath.row == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdPostTextCell, for: indexPath) as? PostTextCell else { return UITableViewCell() }
            
            cell.configureCell(post: testNews[indexPath.section])
            return cell
        }
        else if indexPath.row == 3 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdPostPhotoCell, for: indexPath) as? PostPhotoCell else { return UITableViewCell() }
            
            cell.configureCell(post: testNews[indexPath.section])
            return cell
        }
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdPostLikesCell, for: indexPath) as? PostLikesCell else { return UITableViewCell() }
            cell.configureCell(post: testNews[indexPath.section])
            return cell
        }
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 2 {
            return 300
        } else if indexPath.row == 3 {
            return 400
        } else {
            return UITableView.automaticDimension
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 4 {
            return 40
        } else if indexPath.row == 0 {
            return 1
        } else {
            return UITableView.automaticDimension
        }
    }
}
