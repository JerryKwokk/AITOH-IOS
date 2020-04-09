//
//  PrivateRegion.swift
//  AITOH
//
//  Created by Jerry Kwok on 5/3/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit
import SwiftyJSON

struct PrivateRegion {
    var id:String
    var name: String
    var imagePath: String
    var count: Int
    
    init(id:String, name:String, imagepaths: String, count:Int){
        self.id = id
        self.name = name
        self.imagePath = imagepaths
        self.count = count
    }
    
    init(json: JSON) {
        id = json["id"].stringValue
        name = json["name"].stringValue
        imagePath = json["bgImagePath"].stringValue
        count = json["count"].intValue
    }
}
