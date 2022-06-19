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
    
    func setup (with group: Group) {
        groupName.text = group.name
        numberOfParticipants.text = String(group.numberOfParticipants)
    }
}
