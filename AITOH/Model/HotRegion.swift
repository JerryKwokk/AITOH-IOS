//
//  HotRegion.swift
//  AITOH
//
//  Created by Jerry Kwok on 4/3/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit
import SwiftyJSON
struct HotRegion {
    var id: Int
    var name: String
    var bgImagePath: String
    var description: String
    var count: Int
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
        bgImagePath = ""
        description = ""
        count = 0
    }
    
    init(json: JSON){
        id = json["id"].intValue
        name = json["name"].stringValue
        description = json["description"].stringValue
        bgImagePath = json["bgImagePath"].stringValue
        print(description)
        print(bgImagePath)
        count = json["count"].intValue
    }
}
