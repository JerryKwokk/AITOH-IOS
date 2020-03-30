//
//  File.swift
//  AITOH
//
//  Created by Jerry Kwok on 11/3/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit
import SwiftyJSON
struct RecentView {
    var id:Int
    var historyId: Int
    var iconImagePath: String
    var content: String
    var date: String
    
    init(json: JSON) {
        id = json["id"].intValue
        historyId = json["historyId"].intValue
        iconImagePath = json["user_iconPath"].stringValue
        content = json["description"].stringValue
        date = json["create_date"].stringValue
        print(String(id) + String(historyId) + iconImagePath + content + date)
    }
}
