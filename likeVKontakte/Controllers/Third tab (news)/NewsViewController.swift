//
//  NewsViewController.swift
//  likeVKontakte
//
//  Created by Антон Голубейков on 14.07.2022.
//

import UIKit

class NewsViewController: UIViewController {
    
    let testNews = NewsPost.testPosts
    
    @IBOutlet weak var newsTableView: UITableView!
    
    let reuseIdPostAuthorCell = "PostAuthorCell"
    let reuseIdPostTextCell = "PostTextCell"
    let reuseIdPostPhotoCell = "PostPhotoCell"
    let reuseIdPostLikesCell = "PostLikesCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.delegate = self
        newsTableView.dataSource = self
    }
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        testNews.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdPostAuthorCell, for: indexPath) as? PostAuthorCell else { return UITableViewCell() }
            
            cell.configureCell(post: testNews[indexPath.section])
            return cell
        }
        else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdPostTextCell, for: indexPath) as? PostTextCell else { return UITableViewCell() }
            
            cell.configureCell(post: testNews[indexPath.section])
            return cell
        }
        else if indexPath.row == 2 {
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
}
