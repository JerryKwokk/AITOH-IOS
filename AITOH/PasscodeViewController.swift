//
//  PasscodeViewController.swift
//  AITOH
//
//  Created by Jerry Kwok on 4/4/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit
import SmileLock

class PasscodeViewController: UIViewController,PasswordInputCompleteProtocol {
    func passwordInputComplete(_ passwordContainerView: PasswordContainerView, input: String) {
        if(UserDefaults.standard.string(forKey: "passcode") == input){
            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "TabViewController") as? TabViewController
            vc!.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
            self.dismiss(animated: true, completion: nil)
            self.present(vc!, animated: true, completion: nil)
            
            
        }else{
            lblMessage.textColor = .red
            lblMessage.text = "Enter the Passcode"
            passwordContainerView.tintColor = .red
            passwordContainerView.highlightedColor = .red
            passwordContainerView.clearInput()
        }
    }
    
    func touchAuthenticationComplete(_ passwordContainerView: PasswordContainerView, success: Bool, error: Error?) {
        if(success){
           let storyboard = UIStoryboard(name: "Login", bundle: nil)
           let vc = storyboard.instantiateViewController(identifier: "TabViewController") as? TabViewController
           vc!.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
           self.dismiss(animated: true, completion: nil)
           self.present(vc!, animated: true, completion: nil)
           
        }else{
            lblMessage.textColor = .red
            lblMessage.text = "Enter the Passcode"
            passwordContainerView.tintColor = .red
            passwordContainerView.highlightedColor = .red
        }
    }
    
    
    @IBOutlet weak var lblMessage: UILabel!
    var passwordContainerView: PasswordContainerView!
    let passwordDigit = 4
    var inputPassword: String?
    enum DisplayMode {
        case success, lock
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordContainerView = PasswordContainerView.create(withDigit: passwordDigit)
        let rect = CGRect(x: 0, y: 0, width: passwordContainerView.frame.size.width, height: passwordContainerView.frame.size.height-30)
        passwordContainerView.frame = rect
        passwordContainerView.center = self.view.center
        passwordContainerView.delegate = self
        passwordContainerView.tintColor = .black // brown
        passwordContainerView.highlightedColor = .black // brown
        self.view.addSubview(passwordContainerView)
        lblMessage.text = "Enter the passcode"
        
        // Do any additional setup after loading the view.
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
