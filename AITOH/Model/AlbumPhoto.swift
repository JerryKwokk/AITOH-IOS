//
//  AlbumPhoto.swift
//  AITOH
//
//  Created by Jerry Kwok on 19/2/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit
struct AlbumPhoto {
    var id: String
    var imagePath: String
    var image: UIImage
    var create_date:String
    init(id: String, imagePath: String, image: UIImage, create_date: String) {
        self.id = id
        self.imagePath = imagePath
        self.image = image
        self.create_date = create_date
    }
}
