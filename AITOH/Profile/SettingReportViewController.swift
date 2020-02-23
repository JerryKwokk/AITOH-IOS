//
//  SettingReportViewController.swift
//  AITOH
//
//  Created by Jerry Kwok on 23/2/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit

class SettingReportViewController: UIViewController {

    @IBOutlet weak var viewMon: UIView!
    @IBOutlet weak var viewTue: UIView!
    @IBOutlet weak var viewWed: UIView!
    @IBOutlet weak var viewThu: UIView!
    @IBOutlet weak var viewFir: UIView!
    @IBOutlet weak var viewSat: UIView!
    @IBOutlet weak var viewSun: UIView!
    @IBOutlet weak var avgTime: UITextView!
    @IBOutlet weak var emjJoy: UIView!
    @IBOutlet weak var emjUn: UIView!
    @IBOutlet weak var desc: UITextView!
    @IBOutlet weak var botMes: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func loadUI(){
        botMes.text = "I know you' re going through a difficult time, but I'm always here for you"
        
    }

    @IBAction func btnCancelClick(_ sender: Any) {
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
