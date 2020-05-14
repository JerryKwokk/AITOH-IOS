//
//  Location.swift
//  AITOH
//
//  Created by Jerry Kwok on 13/5/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit
struct Location {
    var id: Int
    var place: String
    var lat: Double
    var long: Double
    
    init(id: Int, place: String, lat: Double, long:Double) {
        self.id = id
        self.place = place
        self.lat = lat
        self.long = long
    }
}
