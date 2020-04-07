//
//  RegionGroupBackgroundCell.swift
//  AITOH
//
//  Created by Jerry Kwok on 7/4/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit

class RegionGroupBackgroundCell: UITableViewCell {

    
    @IBOutlet weak var bgImage: UIImageView!
    func setImage(imagePath: String){
        let url = URL(string: imagePath)
        bgImage.downloadImage(from: url!)
    }

}
