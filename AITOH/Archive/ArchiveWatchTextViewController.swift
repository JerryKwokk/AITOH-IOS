//
//  ArchiveWatchTextViewController.swift
//  AITOH
//
//  Created by Jerry Kwok on 25/3/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit


class ArchiveWatchTextViewController: UIViewController {

    var history:History!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var desc: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Text View")
        let url = URL(string: history.user_iconPath)
        icon.downloadImage(from: url!)
        username.text = history.username
        location.text = history.create_date + " in " + history.location
        desc.text = history.description
        print("desc " + desc.text)
        print("history " + history.description)
        icon.round()
        icon.layer.borderWidth = 3
        // Do any additional setup after loading the view.
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
