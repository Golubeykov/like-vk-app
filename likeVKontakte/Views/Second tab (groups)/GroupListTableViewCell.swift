//
//  GroupListTableViewCell.swift
//  likeVKontakte
//
//  Created by Антон Голубейков on 24.06.2022.
//

import UIKit

class GroupListTableViewCell: UITableViewCell {
    static let reuseIdGroupListTableViewCell = "GroupListTableViewCell"
    @IBOutlet weak var groupLogo: UIImageView!
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var numberOfUsers: UILabel!
    @IBOutlet weak var hardcodedLabelUsers: UILabel!
    
    func configure(group: Group) {
        guard type(of: group) == Group.self else { return }
        if let image = UIImage(named: group.logoName.lowercased()) {
            self.groupLogo.image = image
        } else if let groupPhotoInternetLoaded = UIImage(data: {
            do { let data = try Data(contentsOf: URL(string: group.logoName)!)
                return data
            } catch {
                print("нет такого url")
                print(group.logoName)
                return Data()
            }
        }()
        ) {
            self.groupLogo.image = groupPhotoInternetLoaded
        } else {
            self.groupLogo.image = UIImage(named: "thinkingCat")
        }
        self.groupName.text = group.name
        self.numberOfUsers.text = String(group.numberOfParticipants)
        self.hardcodedLabelUsers.text = "Кол-во участников"
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        groupLogo.image = nil
        groupName.text = nil
        numberOfUsers.text = nil
        hardcodedLabelUsers.text = nil
    }
}
