//
//  SettingDetialViewController.swift
//  AITOH
//
//  Created by Jerry Kwok on 18/2/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit

class SettingDetialViewController: UITableViewController {

    @IBOutlet weak var settingAcPriCell: UITableViewCell!
    @IBOutlet weak var settingTouIDCell: UITableViewCell!
    @IBOutlet weak var settingAcFollCell: UITableViewCell!
    @IBOutlet weak var DisableSettingLogoutCell: UITableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
        // Do any additional setup after loading the view.
    }
    
    func loadUI(){
        settingAcPriCell.selectionStyle = UITableViewCell.SelectionStyle.none
        settingTouIDCell.selectionStyle = UITableViewCell.SelectionStyle.none
        settingAcFollCell.selectionStyle = UITableViewCell.SelectionStyle.none
        DisableSettingLogoutCell.selectionStyle = UITableViewCell.SelectionStyle.none
    }
    
    @IBAction func btnLogoutClick(_ sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: "username")
        UserDefaults.standard.removeObject(forKey: "userId")
        let viewController:UIViewController = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController")
                   viewController.modalPresentationStyle = .fullScreen
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.linear)
                   view.window!.layer.add(transition, forKey: kCATransition)
                   
        self.present(viewController, animated: false, completion: nil)
        //self.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func btnCloseClick(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
