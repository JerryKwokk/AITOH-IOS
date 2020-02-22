//
//  User.swift
//  AITOH
//
//  Created by Jerry Kwok on 21/2/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit
struct User{
    var id: String
    var username: String
    var userIcon: UIImage
    var userIconPath: String
    var fname: String
    
    init(id: String, username: String, fname:String, userIcon:UIImage, userIconPath: String) {
        self.id = id
        self.username = username
        self.userIcon = userIcon
        self.userIconPath = userIconPath
        self.fname = fname
    }
}
