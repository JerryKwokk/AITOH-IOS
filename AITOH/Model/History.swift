//
//  History.swift
//  AITOH
//
//  Created by Jerry Kwok on 19/3/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit
import SwiftyJSON
struct History {
    var id: Int
    var description: String
    var create_date: String
    var location:String
    var username:String
    var userId: Int
    var user_iconPath: String
    var historyMediaId: Int
    var historyMediaPath: String
    var mediaTypeId: Int
    
    init(id: Int, description:String, create_date:String, location: String, username: String, userId:Int, user_iconPath:String, historyMediaId:Int, historyMediaPath:String, mediaTypeId:Int) {
        self.id = id
        self.description = description
        self.create_date = create_date
        self.location = location
        self.username = username
        self.userId = userId
        self.user_iconPath = user_iconPath
        self.historyMediaId = historyMediaId
        self.historyMediaPath = historyMediaPath
        self.mediaTypeId = mediaTypeId
        
    }
    init() {
        id = -1
        description = ""
        create_date = ""
        location = ""
        username = ""
        userId  = -1
        user_iconPath = ""
        historyMediaId = -1
        historyMediaPath = ""
        mediaTypeId = -1
    }
    
    init(json: JSON) {
        id = json["historyId"].intValue
        description = json["description"].stringValue
        create_date = json["create_date"].stringValue
        location = json["location"].stringValue
        username = json["username"].stringValue
        userId = json["userId"].intValue
        user_iconPath = json["user_iconPath"].stringValue
        historyMediaId = json["historyMediaId"].intValue
        historyMediaPath = json["historyMediaPath"].stringValue
        mediaTypeId = json["mediaTypeId"].intValue
    }
    

}
