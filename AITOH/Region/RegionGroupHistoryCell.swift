//
//  RegionGroupHistoryCell.swift
//  AITOH
//
//  Created by Jerry Kwok on 7/4/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit

class RegionGroupHistoryCell: UITableViewCell {

    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var desc: UITextView!
    @IBOutlet weak var mediaImage: UIImageView!
    
    
    func initCommit(history: RegionHistory){
        let url = URL(string: history.userImagePath)
        icon.downloadImage(from: url!)
        username.text = history.username
        location.text = history.date + " in " + history.location
        desc.text = history.desc
        let imgUrl = URL(string: history.historyImagePath)
        mediaImage.downloadImage(from: imgUrl!)
        icon.round()
        icon.layer.borderWidth = 3
    }

}
