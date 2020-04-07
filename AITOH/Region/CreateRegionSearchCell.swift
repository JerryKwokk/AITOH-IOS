//
//  CreateRegionSearchCell.swift
//  AITOH
//
//  Created by Jerry Kwok on 7/4/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit

class CreateRegionSearchCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var username: UILabel!
    func initCommint(user: SuggestedUser){
        let url = URL(string: user.user_iconPath)
        icon.downloadImage(from: url!)
        username.text = user.username
        icon.iconRound()
    }

}
