//
//  AlbumCell.swift
//  AITOH
//
//  Created by Jerry Kwok on 19/2/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit

class AlbumCell: UITableViewCell {

    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    func setAlbum(album: Album){
        bgImage.image = album.bgImage
        title.text = album.title
        subtitle.text = String(album.count) + " items, updated " + String(album.create_date)
    }
    
    @IBAction func btnEditClick(_ sender: UIButton) {
        
    }
    
    
    
    
    
}
