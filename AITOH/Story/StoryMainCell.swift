//
//  StoryMainCell.swift
//  AITOH
//
//  Created by Jerry Kwok on 22/2/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit

class StoryMainCell: UITableViewCell, UITextViewDelegate {

    @IBOutlet weak var selectPhoto: UIImageView!
    @IBOutlet weak var desc: UITextView!
    
    func setSelectPhoto(image:UIImage){
        selectPhoto.image = image
        desc.text = "Placeholder"
        desc.textColor = UIColor.lightGray
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if desc.textColor == UIColor.lightGray {
            desc.text = nil
            desc.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if desc.text.isEmpty {
            desc.text = "Placeholder"
            desc.textColor = UIColor.lightGray
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }

}
