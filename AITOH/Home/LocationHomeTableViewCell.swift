//
//  LocationHomeTableViewCell.swift
//  AITOH
//
//  Created by Jerry Kwok on 2/3/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit

class LocationHomeTableViewCell: UITableViewCell {

    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    func initCommit(region: Region){
        title.text = region.title
        print(region.bgImagePath!)
        let url = URL(string: region.bgImagePath!)
        self.bgImage.downloadImage(from: url!)
        bgImage.image = UIImage(named: "setting")
    }
    
    override func prepareForReuse() {
      super.prepareForReuse()
    }
}
