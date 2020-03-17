//
//  File.swift
//  AITOH
//
//  Created by Jerry Kwok on 11/3/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit
import SwiftyJSON
struct RecebtView {
    var id:Int
    var historyId: Int
    var iconImagePath: String
    var content: String
    var date: String
    
    init(json: JSON) {
        id = json[""].intValue
        historyId = json[""].intValue
        iconImagePath = json[""].stringValue
        content = json[""].stringValue
        date = json[""].stringValue
    }
}
