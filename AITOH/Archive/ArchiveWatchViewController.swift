//
//  ArchiveWatchViewController.swift
//  AITOH
//
//  Created by Jerry Kwok on 11/3/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit
import Alamofire

class ArchiveWatchViewController: UIViewController {

    var id:Int = -1
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var desc: UITextView!
    @IBOutlet weak var image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

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
