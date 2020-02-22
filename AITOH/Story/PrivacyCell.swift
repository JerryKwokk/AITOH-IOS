//
//  PrivacyCell.swift
//  AITOH
//
//  Created by Jerry Kwok on 22/2/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit

class PrivacyCell: UITableViewCell {

    @IBOutlet weak var privacyIcon: UIImageView!
    @IBOutlet weak var privacyTitle: UILabel!
    @IBOutlet weak var privacySubtitle: UILabel!
    
    func setPrivacy(privacy: Privacy){
        privacyIcon.image = privacy.icon
        privacyTitle.text = privacy.title
        privacySubtitle.text = privacy.subtitle
    }

}
