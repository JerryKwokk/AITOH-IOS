//
//  Device.swift
//  AITOH
//
//  Created by Jerry Kwok on 22/2/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit
struct Device {
    var name: String
    var loginTime: String
    var location: String
    
    init(name:String, loginTime: String, location:String) {
        self.name = name
        self.loginTime = loginTime
        self.location = location
    }
}
