//
//  SelectedPhoto.swift
//  AITOH
//
//  Created by Jerry Kwok on 27/3/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit
struct SelectedPhoto {
    var image:UIImage
    var location: String
    var address:String
    var lat:Double
    var long:Double
    
    init(image:UIImage, location:String, address: String, lat:Double, long:Double) {
        self.image = image
        self.location = location
        self.address = ""
        self.lat = lat
        self.long = long
    }
    
}
