//
//  RegionGroupLocationCell.swift
//  AITOH
//
//  Created by Jerry Kwok on 13/5/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit

class RegionGroupLocationCell: UICollectionViewCell {
    
    var btnSelected = false
    
    @IBOutlet weak var button: UIButton!
    func initElement(location: Location){
        button.setTitle(location.place, for: .normal)
        button.layer.cornerRadius = 8
    }
    func checkSelected(){
        if btnSelected {
            button.setBackgroundColor(UIColor.gray, forState: .normal)
            button.layer.cornerRadius = 8
        }else{
            button.setBackgroundColor(UIColor.lightGray, forState: .normal)
            button.layer.cornerRadius = 8
        }
        
    }
    @IBAction func btnClick(_ sender: Any) {
        
        if btnSelected {
            btnSelected = false
        }else {
            btnSelected = true
        }
        checkSelected()
    }
    
}
