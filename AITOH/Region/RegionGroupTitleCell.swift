//
//  RegionGroupTitleCell.swift
//  AITOH
//
//  Created by Jerry Kwok on 7/4/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit

class RegionGroupTitleCell: UITableViewCell {

    @IBOutlet weak var titile: UILabel!
    @IBOutlet weak var desc: UILabel!
    var viewController:UIViewController!
    
    func setDetial(title: String, policy: Bool, member: Int){
        titile.text = title
        if policy {
            desc.text = "Public Group, " + String(member) + " member"
        }else{
            desc.text = "Private Group, " + String(member) + " member"
        }
    }
    
    @IBAction func btnTimeTrackeClick(_ sender: Any) {
       
    }
    
    

}
