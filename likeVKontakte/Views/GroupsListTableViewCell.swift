//
//  GroupsListTableViewCell.swift
//  likeVKontakte
//
//  Created by Антон Голубейков on 19.06.2022.
//

import UIKit

class GroupsListTableViewCell: UITableViewCell {
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var numberOfParticipants: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
