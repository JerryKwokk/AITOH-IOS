//
//  PrivateGroupTableViewCell.swift
//  AITOH
//
//  Created by Jerry Kwok on 5/3/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit

class PrivateGroupTableViewCell: UITableViewCell {

    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    
    func initCommit(region: PrivateRegion){
        title.text = region.name
        subtitle.isHidden = true
        let url = URL(string: region.imagePath)
        icon.downloadImage(from: url!)
        icon.round()
        icon.layer.borderWidth = 0
    }
}
