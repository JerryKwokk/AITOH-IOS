//
//  UIImageView.swift
//  AITOH
//
//  Created by Jerry Kwok on 18/2/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit

extension UIImageView{
    func round(){
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
        self.layer.borderWidth = 10
        self.layer.borderColor = UIColor.white.cgColor
    }
}
