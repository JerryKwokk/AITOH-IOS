//
//  AlbumDetailCollectionViewCell.swift
//  AITOH
//
//  Created by Jerry Kwok on 20/2/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    
    @IBOutlet weak var AlbumPhoto: UIImageView!
    func setAlbumPhoto(albumPhoto: AlbumPhoto){
        AlbumPhoto.image = albumPhoto.image
    }
    
}
