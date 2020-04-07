//
//  ReginGroupSearchCell.swift
//  AITOH
//
//  Created by Jerry Kwok on 5/4/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit

class ReginGroupSearchCell: UITableViewCell {

    
    @IBOutlet weak var regionImage: UIImageView!
    @IBOutlet weak var regionTitle: UILabel!
    
    func initCommit(rg: RegionGroup){
        let iconImagePath = URL(string: rg.bgImagePath)
        regionImage.downloadImage(from: iconImagePath!)
        regionTitle.text = rg.name
        regionImage.round()
        regionImage.layer.borderWidth = 2
    }

}
