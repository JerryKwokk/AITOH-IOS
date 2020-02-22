//
//  SettingLoginActivityTableCellTableViewCell.swift
//  AITOH
//
//  Created by Jerry Kwok on 22/2/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit

class SettingLoginActivityTableCellTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    var delegate: LoginActivityCellDelegate?
    func setDevice(device: Device){
        title.text = device.location
        let modelName = UIDevice.modelName
        if(modelName == device.name){
            subtitle.text = "Active Now . " + device.loginTime
        }else{
            subtitle.text = device.name + " . " + device.loginTime
        }
        
        
    }
    @IBAction func btnMoreClick(_ sender: UIButton) {
      /*  let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        let logout = UIAlertAction(title: "Logout", style: .default) { action in
            self.Logout()
        }
        
        
        actionSheet.addAction(logout)
        actionSheet.addAction(cancel)
        
        self.present(actionSheet, animated: true, completion: nil)
    */}
    
}

protocol LoginActivityCellDelegate {
    func didTapWatchLater(title: String)
    func didTapWatchNow(url: String)
}
