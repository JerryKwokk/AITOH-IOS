//
//  ProfileMainCell.swift
//  AITOH
//
//  Created by Jerry Kwok on 23/2/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit

class ProfileMainCell: UITableViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var privacy: UIImageView!
    @IBOutlet weak var follower: UIButton!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var following: UIButton!
    @IBOutlet weak var desc: UITextView!
    @IBOutlet weak var btnEditProfile: UIButton!
    
    func setup(user: UserProfile){
        iconImage.image = user.iconImage
        if(user.privacy){
            privacy.isHidden = false
        }else{
            privacy.isHidden = true
        }
        follower.setTitle(String(user.follower), for: .normal)
        following.setTitle(String(user.following), for: .normal)
        username.text = user.username
        bgImage.image = user.bgImage
        desc.text = user.desr
        btnEditProfile.format()
        iconImage.round()
        bgImage.layer.cornerRadius = 20
    }
}
