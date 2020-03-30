//
//  RecentlyViewCell.swift
//  AITOH
//
//  Created by Jerry Kwok on 11/3/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit

class RecentlyViewCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var timeline: UILabel!
    
    func initCommit(recent: RecentView){
       print(recent)
        content.text = recent.content
        timeline.text = recent.date + " view"
        let url = URL(string: recent.iconImagePath)
        icon.downloadImage(from: url!)
        icon.round()
        icon.layer.borderWidth = 3
    }

}
