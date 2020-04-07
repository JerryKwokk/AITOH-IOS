//
//  SuggestedUser.swift
//  AITOH
//
//  Created by Jerry Kwok on 7/4/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit
import SwiftyJSON
struct SuggestedUser {
    var id: Int
    var username: String
    var user_iconPath: String
    
    init(id:Int, username:String, user_iconPath:String) {
        self.id = id
        self.username = username
        self.user_iconPath = user_iconPath
    }
    
    init(json: JSON) {
        id = json["assoUserId"].intValue
        user_iconPath = json["user_iconPath"].stringValue
        username = json["username"].stringValue
    }
}
