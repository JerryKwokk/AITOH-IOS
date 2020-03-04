//
//  Region.swift
//  AITOH
//
//  Created by Jerry Kwok on 2/3/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit
import SwiftyJSON
struct Region: Decodable {
    var id:Int?
    var title: String?
    var bgImagePath:String?
    
    init(json: JSON){
        title = json["region"].stringValue
        id = json["regionId"].intValue
        bgImagePath = json["regionImagePath"].stringValue
    }
    
}

