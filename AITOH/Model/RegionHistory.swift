//
//  RegionHistory.swift
//  AITOH
//
//  Created by Jerry Kwok on 5/3/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit
import SwiftyJSON

struct RegionHistory {
    var id:Int
    var userId: Int
    var username: String
    var userImagePath: String
    var date: String
    var desc: String
    var location: String
    var long:Double
    var lat:Double
    var historyImagePath: String
    
    init(json: JSON) {
        id = json["regionHistoryId"].intValue
        userId = json["userId"].intValue
        username = json["username"].stringValue
        userImagePath = json["user_iconPath"].stringValue
        date = json["create_date"].stringValue
        desc = json["description"].stringValue
        lat = json["latitude"].doubleValue
        long = json["longitude"].doubleValue
        location = json["location"].stringValue
        historyImagePath = json["historyMediaPath"].stringValue
        print("check null: " + historyImagePath)
        print("finish")
    }
    
    init(id:Int, userId: Int, username: String, userImagePath: String, date: String, desc: String, location: String, long:Double, lat:Double, historyImagePath: String){
        self.id = id
        self.userId = userId
        self.username = username
        self.userImagePath = userImagePath
        self.date = date
        self.desc = desc
        self.location = location
        self.long = long
        self.lat = lat
        self.historyImagePath = historyImagePath
    }
}

