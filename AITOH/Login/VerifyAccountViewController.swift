//
//  VerifyAccountViewController.swift
//  AITOH
//
//  Created by Jerry Kwok on 9/4/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class VerifyAccountViewController: UIViewController {

    @IBOutlet weak var des: UITextView!
    @IBOutlet weak var code: UITextField!
    @IBOutlet weak var btnVerify: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var resendMes: UILabel!
    var user:User!
    var forget:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
        // Do any additional setup after loading the view.
    }
    
    func loadUI(){
        btnCancel.layer.cornerRadius = 5
        btnVerify.layer.cornerRadius = 5
        if forget {
            des.text = "The verify code is send to " + user.username + " associated phone number"
            navBar.title = "Forget Password"
            sendForgetMessage()
        }else{
            des.text = "Thank you for your signup. You need to verify your phone number, the verify send to " + user.phone
        }
        
        
        resendMes.isHidden = true
    }
    
    func sendForgetMessage(){
        AF.request(URL.init(string: "https://cuvfsx9pda.execute-api.us-east-1.amazonaws.com/aitoh/verify&username=" + user.username + "&forget=true" )!, method: .get, encoding: JSONEncoding.default).responseJSON { (response) in

            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    @IBAction func btnVerifyClick(_ sender: Any) {
        if(code.text == ""){
            resendMes.text = "The verify is wrong"
            resendMes.textColor = .red
        }else{
            if forget {
                
            }else{
                let storyboard = UIStoryboard(name: "Login", bundle: nil)
                let viewController:TabViewController = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "TabViewController") as! TabViewController
                AF.request(URL.init(string: "https://cuvfsx9pda.execute-api.us-east-1.amazonaws.com/aitoh/verify")!, method: .get, parameters: ["code": code.text, "phone": user.phone], encoding: JSONEncoding.default).responseJSON { (response) in

                        switch response.result {
                        case .success(let value):
                            let json = JSON(value)
                            print(json)
                            if !json["verify"].boolValue {
                                self.resendMes.text = "The verify is wrong"
                                self.resendMes.textColor = .red
                            }else{
                                UserDefaults.standard.set(json["userId"].stringValue, forKey: "userId")
                                UserDefaults.standard.set(json["username"].stringValue,forKey: "username")
                                print(UserDefaults.standard.value(forKey: "userId"))
                                viewController.modalPresentationStyle = .fullScreen
                                let transition = CATransition()
                                transition.duration = 0.3
                                transition.type = CATransitionType.push
                                transition.subtype = CATransitionSubtype.fromRight
                                transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.linear)
                                self.view.window!.layer.add(transition, forKey: kCATransition)
                                
                                self.present(viewController, animated: false, completion: nil)
                            }
                            break
                        case .failure(let error):
                            print(error)
                            break
                        }
                    }
            
            }
        }
    }
    
    @IBAction func btnBackClick(_ sender: Any) {
        if !forget {
            AF.request(URL.init(string: "https://cuvfsx9pda.execute-api.us-east-1.amazonaws.com/aitoh/verify")!, method: .delete, parameters: ["username": user.username ,"password": user.password, "phone": user.phone, "fname": user.fname], encoding: JSONEncoding.default).responseJSON { (response) in

                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print(json)
                    break
                case .failure(let error):
                    print(error)
                    break
                }
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnResend(_ sender: Any) {
        if forget {
            sendForgetMessage()
        }else{
            AF.request(URL.init(string: "https://cuvfsx9pda.execute-api.us-east-1.amazonaws.com/aitoh/verify&phone=" + user.phone)!, method: .get, encoding: JSONEncoding.default).responseJSON { (response) in

                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    print(json)
                    self.resendMes.text = "The message resend"
                    self.resendMes.textColor = .black
                    break
                case .failure(let error):
                    print(error)
                    break
                }
            }
        }
        
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
