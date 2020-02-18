//
//  UIButton.swift
//  AITOH
//
//  Created by Jerry Kwok on 18/2/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit
extension UIButton{
    func format(){
        self.backgroundColor = .clear
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
    }
}
