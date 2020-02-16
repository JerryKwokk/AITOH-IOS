//
//  SignUpVIewControllerViewController.swift
//  AITOH
//
//  Created by Jerry Kwok on 16/2/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit

class SignUpViewControllerViewController: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
        // Do any additional setup after loading the view.
    }
    
    func loadUI(){
        txtUsername.borderStyle = UITextField.BorderStyle.roundedRect
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 0))
        txtUsername.leftView = leftView
        txtUsername.leftViewMode = .always
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
