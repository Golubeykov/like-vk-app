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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(group: Group) {
        if let image = UIImage(named: group.logoName.lowercased()) {
            self.groupLogo.image = image
        }
        self.groupName.text = group.name
        self.numberOfUsers.text = String(group.numberOfParticipants)
    }
}
