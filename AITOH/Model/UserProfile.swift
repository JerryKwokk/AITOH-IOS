//
//  UserProfile.swift
//  AITOH
//
//  Created by Jerry Kwok on 23/2/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit
struct UserProfile {
    var userId:String
    var username:String
    var privacy:Bool
    var follower:Int
    var following:Int
    var desr: String
    var iconImage: UIImage
    var bgImage: UIImage
    
    init(userId: String, username:String, privacy:Bool, follower:Int, following:Int, desr:String, iconImage: UIImage, bgImage: UIImage) {
        self.userId = userId
        self.username = username
        self.privacy = privacy
        self.follower = follower
        self.following = following
        self.desr = desr
        self.iconImage = iconImage
        self.bgImage = bgImage
    }
    
    
}
