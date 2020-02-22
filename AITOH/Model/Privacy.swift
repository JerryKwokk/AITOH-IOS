//
//  Privacy.swift
//  AITOH
//
//  Created by Jerry Kwok on 22/2/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit
struct Privacy {
    var id:String
    var title: String
    var icon: UIImage
    var subtitle: String
    
    init(id:String, title: String, icon:UIImage, subtitle: String) {
        self.id = id
        self.title = title
        self.icon = icon
        self.subtitle = subtitle
    }
}
