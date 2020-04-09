//
//  User.swift
//  AITOH
//
//  Created by Jerry Kwok on 21/2/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit
import SwiftyJSON
struct User{
    var id: String
    var username: String
    var userIcon: UIImage
    var userIconPath: String
    var fname: String
    var phone: String
    var password: String
    
    init(id: String, username: String, fname:String, userIcon:UIImage, userIconPath: String) {
        self.id = id
        self.username = username
        self.userIcon = userIcon
        self.userIconPath = userIconPath
        self.fname = fname
        self.phone = ""
        self.password = ""
    }
    
    init(username:String) {
        self.id = ""
        self.username = username
        self.userIcon = UIImage(named: "defaultIcon")!
        self.userIconPath = ""
        self.fname = ""
        self.phone = ""
        self.password = ""
    }
    
    init(username:String, fname:String, phone: String, password:String) {
        self.username = username
        self.fname = fname
        self.password = password
        self.phone = phone
        id = ""
        userIcon = UIImage(named: "defaultIcon")!
        userIconPath = ""
    }
    
    init(json:JSON) {
        id = json["userId"].stringValue
        username = json["usernmae"].stringValue
        userIconPath = json["userIconPath"].stringValue
        userIcon = UIImage(named: "defaultIcon")!
        fname = json["fname"].stringValue
        phone = json["phone"].stringValue
        password = json["password:"].stringValue
        
    }
}
