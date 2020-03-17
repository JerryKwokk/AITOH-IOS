//
//  File.swift
//  AITOH
//
//  Created by Jerry Kwok on 11/3/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit
import SwiftyJSON
struct Archive {
    var id:Int
    var historyId: Int
    var iconImagePath: String
    var content: String
    var date: String
    
    init(json: JSON) {
        print("archive " + String(json["id"].intValue))
        id = json["id"].intValue
        historyId = json["historyId"].intValue
        iconImagePath = json["user_iconPath"].stringValue
        if(json["description"].stringValue == "" || json["description"].stringValue == nil){
            content = "Photo Album"
        }
        content = json["description"].stringValue
        date = json["create_date"].stringValue
        print(date + content + iconImagePath)
    }
}
