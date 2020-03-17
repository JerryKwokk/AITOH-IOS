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
    
    func initCommit(archive: RecebtView){
        content.text = archive.content
        timeline.text = archive.date + " view"
        let url = URL(string: archive.iconImagePath)
        icon.downloadImage(from: url!)
    }

}
