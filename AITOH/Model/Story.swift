//
//  Story.swift
//  AITOH
//
//  Created by Jerry Kwok on 22/2/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit

struct Story {
    var id:String
    var username: String
    var icon: UIImage
    var iconPath: String
    var desc: String
    var time: String
    var location: String
    var img:UIImage
    var imgPath:String
    
    init(id:String, username: String, icon:UIImage, iconPath:String, desc:String, time:String, location:String, img:UIImage, imgPath:String) {
        self.id = id
        self.username = username
        self.icon = icon
        self.iconPath = iconPath
        self.desc = desc
        self.time = time
        self.location = location
        self.img = img
        self.imgPath = imgPath
    }
}
