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
    @IBOutlet weak var btnEditProfile: UIButton!
    
    @IBOutlet weak var profilePostCollection: UICollectionViewCell!
    
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
        btnEditProfile.format()
        iconImage.round()
        bgImage.layer.cornerRadius = 20
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
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
