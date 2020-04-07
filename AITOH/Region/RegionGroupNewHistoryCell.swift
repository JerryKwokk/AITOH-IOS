//
//  RegionGroupNewHistoryCell.swift
//  AITOH
//
//  Created by Jerry Kwok on 7/4/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit

class RegionGroupNewHistoryCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    
    func setIcon(){
        
        icon.round()
        icon.layer.borderWidth = 1
    }

}
