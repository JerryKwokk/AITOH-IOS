//
//  SettingTouchIDViewController.swift
//  AITOH
//
//  Created by Jerry Kwok on 23/2/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit

import SmileLock

class SettingTouchIDViewController: UIViewController,PasswordInputCompleteProtocol {
    func touchAuthenticationComplete(_ passwordContainerView: PasswordContainerView, success: Bool, error: Error?) {
     print(success)
    }
    
    
    func passwordInputComplete(_ passwordContainerView: PasswordContainerView, input: String) {
        passwordContainerView.clearInput()
        if(mode == DisplayMode.confirm){
            if(input != inputPassword){

                lblMessage.text = "Confrim Password Wrong"
                passwordContainerView.tintColor = .red
                passwordContainerView.highlightedColor = .red
                lblMessage.textColor = .red
                print("not same")
                
            }else{
                print("save")
                UserDefaults.standard.set(input, forKey: "passcode")
                lblMessage.text = "The passcode is save"
                self.dismiss(animated: true, completion: nil)
            }
            
        }else if(mode == DisplayMode.register || mode == DisplayMode.error){
            if(UserDefaults.standard.string(forKey: "passcode") == input){
                mode = DisplayMode.initi
            }else{
                mode = DisplayMode.error
            }
            checkStep()
        }else{
            inputPassword = input
            print(input)
            mode = DisplayMode.confirm
            checkStep()
        }
        
        
        
    }
    

    @IBOutlet weak var lblMessage: UILabel!

    var mode: DisplayMode!
    let passwordDigit = 4
    var inputPassword: String?
    var passwordContainerView: PasswordContainerView!
    
    enum DisplayMode {
    case confirm, register, initi, error
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if((UserDefaults.standard.string(forKey: "passcode")) != nil){
            mode = DisplayMode.register
        }
       passwordContainerView = PasswordContainerView.create(withDigit: passwordDigit)
        let rect = CGRect(x: 0, y: 0, width: passwordContainerView.frame.size.width, height: passwordContainerView.frame.size.height-30)
        passwordContainerView.frame = rect
        passwordContainerView.touchAuthenticationEnabled = false
        //passwordContainerView.isVibrancyEffect = true
        passwordContainerView.center = self.view.center
        passwordContainerView.delegate = self
        passwordContainerView.tintColor = .black // brown
        passwordContainerView.highlightedColor = .black // brown
        self.view.addSubview(passwordContainerView)

       checkStep()
       
    }
        
        func checkStep(){
            lblMessage.textColor = .black
            if mode == DisplayMode.confirm {
                       print("1")
                   lblMessage.text = "Confirm the passcode"
                   passwordContainerView.highlightedColor = .black
                    passwordContainerView.tintColor = .black
                   } else if mode == DisplayMode.register {
                       print("2")
                   lblMessage.text = "Insert your passcode to reset"
                  passwordContainerView.highlightedColor = .black
                passwordContainerView.tintColor = .black
            } else if mode == DisplayMode.error{
                lblMessage.text = "Input Value wrong"
                passwordContainerView.tintColor = .red
                passwordContainerView.highlightedColor = .red
                lblMessage.textColor = .red
            } else {
                   print("3")
                   lblMessage.text = "Insert your new passcode"
                passwordContainerView.tintColor = .black
                passwordContainerView.highlightedColor = .black
        }
    
        func btnLoggingClick(_ sender: Any) {
        // 創建 LAContext 實例
       /* let context = LAContext()
        // 設置取消按鈕標題
        context.localizedCancelTitle = "Cancel"
        var error: NSError?
        // 評估是否可以針對給定方案進行身份驗證
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            let reason = "Log in to your account"
            // 評估指定方案
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { (success, error) in
                if success {
                    DispatchQueue.main.async { [unowned self] in
                        self.showMessage(title: "Login Successful", message: nil)
                    }
                } else {
                    DispatchQueue.main.async { [unowned self] in
                        self.showMessage(title: "Login Failed", message: error?.localizedDescription)
                    }
                }
            }
        } else {
            showMessage(title: "Failed", message: error?.localizedDescription)
        }*/
    }
    
    func showMessage(title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
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
}
