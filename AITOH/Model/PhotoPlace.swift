//
//  PhotoPlace.swift
//  AITOH
//
//  Created by Jerry Kwok on 20/2/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit

struct PhotoPlace{
    var name: String
    var lat: Double
    var long:Double
    var imgPath: String
    var img: UIImage
    
    init(name: String, lat: Double, long: Double, imgPath: String, img: UIImage) {
        self.name = name
        self.lat = lat
        self.long = long
        self.imgPath = imgPath
        self.img = img
    }
    
    init(name: String, lat: Double, long: Double){
        self.name = name
        self.lat = lat
        self.long = long
        imgPath = "null"
        img = UIImage(named: "test.jpg")!
    }
    
}
