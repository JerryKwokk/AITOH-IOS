//
//  ProfileViewController.swift
//  AITOH
//
//  Created by Jerry Kwok on 17/2/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var follower: UIButton!
    @IBOutlet weak var following: UIButton!
    @IBOutlet weak var descrip: UITextView!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var iconImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
        // Do any additional setup after loading the view.
    }
    
    func loadUI(){
        username.text = UserDefaults.standard.value(forKey: "username") as? String;
        follower.setTitle("346", for: .normal)
        following.setTitle("18", for: .normal)
        iconImage.layer.cornerRadius = iconImage.frame.size.width / 2
        iconImage.clipsToBounds = true
        bgImage.layer.cornerRadius = 20
        iconImage.layer.borderWidth = 10
        iconImage.layer.borderColor = UIColor.white.cgColor
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
