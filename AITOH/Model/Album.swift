//
//  Album.swift
//  AITOH
//
//  Created by Jerry Kwok on 19/2/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit
struct Album{
    var id: String
    var title: String
    var bgImage: UIImage
    var imagePath: String
    var count: Int
    var create_date: String
    
    init(id: String, title: String, bgImage: UIImage, imagePath: String, count: Int, create_date: String) {
        self.id = id
        self.title = title
        self.bgImage = bgImage
        self.imagePath = imagePath
        self.count = count
        self.create_date = create_date
    }
}
