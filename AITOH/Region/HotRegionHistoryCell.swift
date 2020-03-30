//
//  HotRegionHistoryCell.swift
//  AITOH
//
//  Created by Jerry Kwok on 5/3/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit

class HotRegionHistoryCell: UICollectionViewCell {
    
    var id:Int = -1
    var username = ""
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var des: UITextView!
    @IBOutlet weak var image: UIImageView!
    
    func initCommit(region: RegionHistory){
        id = region.id
        username = region.username
        title.text = region.username
        subtitle.text = region.date + " in " + region.location
        des.text = region.desc
        let url = URL(string: region.userImagePath)
        icon.downloadImage(from: url!)
        icon.round()
        if(region.historyImagePath != "" && URL(string: region.historyImagePath) != nil){
            let url = URL(string: region.historyImagePath)
            image.downloadImage(from: url!)
        }else{
            des.translatesAutoresizingMaskIntoConstraints = true
            des.isScrollEnabled = false
        }
    }
    
    
    
    
    
    
}
