//
//  ArchiveCell.swift
//  AITOH
//
//  Created by Jerry Kwok on 11/3/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit

class ArchiveCell: UITableViewCell {

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var content: UITextView!
    @IBOutlet weak var timeline: UILabel!
    
    func initCommit(archive: Archive){
        print("init commit")
        content.text = archive.content
        timeline.text = archive.date + " archived"
        let url = URL(string: archive.iconImagePath)
        icon.downloadImage(from: url!)
        icon.round()
        icon.layer.borderWidth = 3
    }
    
}
