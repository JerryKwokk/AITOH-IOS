//
//  FollowerTableViewCell.swift
//  AITOH
//
//  Created by Jerry Kwok on 21/2/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit

class FollowerTableViewCell: UITableViewCell {

    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var fName: UILabel!
    func setUser(user: User){
        icon.image = user.userIcon
        icon.round()
        icon.layer.borderWidth = 0.3
        icon.layer.borderColor = UIColor.gray.cgColor
        username.text = user.username
        fName.text = user.fname
    }
    
}
