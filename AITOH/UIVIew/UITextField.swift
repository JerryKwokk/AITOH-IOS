//
//  UITextField.swift
//  AITOH
//
//  Created by Jerry Kwok on 23/2/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit
extension UITextField{
    func format(){
        self.backgroundColor = .clear
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
    }
    
    func loginFormat(){
        self.addLine(position: .LINE_POSITION_BOTTOM, color: .darkGray, width: 0.5)
    }
}
