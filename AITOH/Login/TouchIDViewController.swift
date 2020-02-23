//
//  TouchIDViewController.swift
//  AITOH
//
//  Created by Jerry Kwok on 19/2/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit
import LocalAuthentication

class TouchIDViewController: UIViewController {

   
    @IBOutlet weak var btnOne: UIButton!
    @IBOutlet weak var btnTwo: UIButton!
    @IBOutlet weak var btnThree: UIButton!
    @IBOutlet weak var btnFour: UIButton!
    @IBOutlet weak var btnFive: UIButton!
    @IBOutlet weak var btnSix: UIButton!
    @IBOutlet weak var btnSeven: UIButton!
    @IBOutlet weak var btnEight: UIButton!
    @IBOutlet weak var btnNine: UIButton!
    @IBOutlet weak var btnZero: UIButton!
    @IBOutlet weak var btnClear: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var inputOne: UIView!
    @IBOutlet weak var inputTwo: UIView!
    @IBOutlet weak var inputThree: UIView!
    @IBOutlet weak var inputFour: UIView!
    var inputCode = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUI()
        logging()
        // Do any additional setup after loading the view.
    }
    func loadUI(){
        btnOne.layer.cornerRadius = 0.5 * btnOne.bounds.size.width
        btnOne.clipsToBounds = true
        btnOne.layer.borderColor = UIColor.black.cgColor
        btnOne.layer.borderWidth = 2
        
        btnTwo.layer.cornerRadius = btnOne.frame.size.width/2
        btnTwo.layer.borderColor = UIColor.black.cgColor
        btnTwo.layer.borderWidth = 3
        btnThree.layer.cornerRadius = btnOne.frame.size.width/2
        btnThree.layer.borderColor = UIColor.black.cgColor
        btnThree.layer.borderWidth = 3
        btnFour.layer.cornerRadius = btnOne.frame.size.width/2
        btnFour.layer.borderColor = UIColor.black.cgColor
        btnFour.layer.borderWidth = 3
        btnFive.layer.cornerRadius = btnOne.frame.size.width/2
        btnFive.layer.borderColor = UIColor.black.cgColor
        btnFive.layer.borderWidth = 3
        btnSix.layer.cornerRadius = btnOne.frame.size.width/2
        btnSix.layer.borderColor = UIColor.black.cgColor
        btnSix.layer.borderWidth = 3
        btnSeven.layer.cornerRadius = btnOne.frame.size.width/2
        btnSeven.layer.borderColor = UIColor.black.cgColor
        btnSeven.layer.borderWidth = 3
        btnEight.layer.cornerRadius = btnOne.frame.size.width/2
        btnEight.layer.borderColor = UIColor.black.cgColor
        btnEight.layer.borderWidth = 3
        btnNine.layer.cornerRadius = btnOne.frame.size.width/2
        btnNine.layer.borderColor = UIColor.black.cgColor
        btnNine.layer.borderWidth = 3
        btnZero.layer.cornerRadius = btnOne.frame.size.width/2
        btnZero.layer.borderColor = UIColor.black.cgColor
        btnZero.layer.borderWidth = 3
        inputOne.layer.cornerRadius = 10
        inputOne.layer.borderWidth = 2
        inputOne.layer.borderColor = UIColor.black.cgColor
        inputTwo.layer.cornerRadius = 10
        inputTwo.layer.borderWidth = 2
        inputTwo.layer.borderColor = UIColor.black.cgColor
        inputThree.layer.cornerRadius = 10
        inputThree.layer.borderWidth = 2
        inputThree.layer.borderColor = UIColor.black.cgColor
        inputFour.layer.cornerRadius = 10
        inputFour.layer.borderWidth = 2
        inputFour.layer.borderColor = UIColor.black.cgColor
        
    }
    
    @IBAction func inputKeycode(_ sender: UIButton) {
        switch sender{
            case btnOne:
                inputCode += "1"
            break
        case btnTwo:
            inputCode += "2"
            break
        case btnThree:
            inputCode += "3"
            break
        case btnFour:
            inputCode += "4"
            break
        case btnFive:
            inputCode += "5"
            break
        case btnSix:
            inputCode += "6"
            break
        case btnSeven:
            inputCode += "7"
            break
        case btnEight:
            inputCode += "8"
            break
        case btnNine:
            inputCode += "9"
            break
        case btnZero:
            inputCode += "0"
            break
        case btnDelete:
            inputCode.removeLast()
            break
        default:
            inputCode = ""
        }
        checkInputKeyCount()
    }
    
    func checkInputKeyCount(){
        if inputCode.count == 1 {
            inputOne.backgroundColor = UIColor.lightGray
        }else if inputCode.count == 2{
            inputTwo.backgroundColor = UIColor.lightGray
        }else if inputCode.count == 3{
            inputThree.backgroundColor = UIColor.lightGray
        }else if inputCode.count == 4{
            inputFour.backgroundColor = UIColor.lightGray
            
        }else{
            inputOne.backgroundColor = UIColor.white
            inputTwo.backgroundColor = UIColor.white
            inputThree.backgroundColor = UIColor.white
            inputFour.backgroundColor = UIColor.white
        }
    }
    
    func checkPassCode(){
        if(inputCode == UserDefaults.standard.string(forKey: "touchID")){
            logged()
        }
    }
    
    func logging(){
        // 創建 LAContext 實例
        let context = LAContext()
        // 設置取消按鈕標題
        context.localizedCancelTitle = "Cancel"
        var error: NSError?
        // 評估是否可以針對給定方案進行身份驗證
        
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            let reason = "Log in to your account"
            // 評估指定方案
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { (success, error) in
                for _ in 0...4{
                    if success {
                        self.logged()
                        
                    } else {
                        break
                    }
                }
                
            }
        } else {
            //showMessage(title: "Failed", message: error?.localizedDescription)
        }
        
    }
    
    func logged(){
        let viewController:UIViewController = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "TabViewController")
        viewController.modalPresentationStyle = .fullScreen
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.linear)
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        self.present(viewController, animated: false, completion: nil)
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
