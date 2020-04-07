//
//  RegionGroup.swift
//  AITOH
//
//  Created by Jerry Kwok on 5/4/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit
import SwiftyJSON
struct RegionGroup {
    var id:Int
    var name:String
   // var iconPath:String
    var bgImagePath:String
    var desription: String
    var date: String
    var regionId: Int
    var userId: Int
    
    init(id:Int, name:String, bgImagePath:String, description: String, date: String, regionId: Int, userId: Int) {
        self.id = id
   //     self.iconPath = iconPath
        self.bgImagePath = bgImagePath
        self.desription = description
        self.date = date
        self.regionId = regionId
        self.userId = userId
        self.name = name
    }
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
        self.bgImagePath = ""
        self.desription = ""
        self.date = ""
        self.regionId = 0
        self.userId = 0
        self.name = ""
        
    }
    
    init(json:JSON) {
        id = json["id"].intValue
       // iconPath = json["iconPath"].stringValue
        bgImagePath = json["bgImagePath"].stringValue
        desription = json["description"].stringValue
        date = json["create_date"].stringValue
        regionId = json["regionId"].intValue
        userId = json["userId"].intValue
        name = json["name"].stringValue
    }
}
