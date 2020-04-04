//
//  LoginViewController.swift
//  AITOH
//
//  Created by Jerry Kwok on 28/1/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

enum LINE_POSITION {
    case LINE_POSITION_TOP
    case LINE_POSITION_BOTTOM
}

extension UIView {
    func addLine(position : LINE_POSITION, color: UIColor, width: Double) {
        let lineView = UIView()
        lineView.backgroundColor = color
        lineView.translatesAutoresizingMaskIntoConstraints = false // This is important!
        self.addSubview(lineView)

        let metrics = ["width" : NSNumber(value: width)]
        let views = ["lineView" : lineView]
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[lineView]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))

        switch position {
        case .LINE_POSITION_TOP:
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[lineView(width)]", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
        case .LINE_POSITION_BOTTOM:
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[lineView(width)]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
            break
        }
    }
}

class LoginViewController: UIViewController {
    @IBOutlet weak var gradientView: UIImageView!
    @IBOutlet weak var imgLoginBackground: UIImageView!
    @IBOutlet weak var txtLoginPassword: UITextField!
    @IBOutlet weak var txtLoginUsername: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var viewLoginPanel: UIView!
    @IBOutlet weak var viewForgetPanel: UIView!
    @IBOutlet weak var txtForget: UITextField!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnSendVerifyCode: UIButton!
    @IBOutlet weak var lblVerifyCodeMess: UILabel!
    @IBOutlet weak var lblErrorMess: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUi()
        
        
        // Do any additional setup after loading the view.
    }
    func animateBackgrounfColor(){
        UIView.animate(withDuration: 2, delay: 0, options: [.autoreverse, .curveLinear, .repeat], animations:{
            let x = -(self.gradientView.frame.width - self.view.frame.width - (self.gradientView.frame.width/2))
            self.gradientView.transform = CGAffineTransform(translationX: x, y: 0)})
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    func loadUi(){
        animateBackgrounfColor()
        btnLogin.backgroundColor = .clear
        btnLogin.layer.cornerRadius = 5
        btnLogin.layer.borderWidth = 1
        btnLogin.layer.borderColor = UIColor.black.cgColor
        btnBack.backgroundColor = .clear
        btnBack.layer.cornerRadius = 5
        btnBack.layer.borderWidth = 1
        btnBack.layer.borderColor = UIColor.black.cgColor
        btnSendVerifyCode.layer.cornerRadius = 5
        lblVerifyCodeMess.isHidden = true
        txtForget.borderStyle = UITextField.BorderStyle.roundedRect
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 0))
        txtForget.leftView = leftView
        txtForget.leftViewMode = .always
        txtLoginUsername.addLine(position: .LINE_POSITION_BOTTOM, color: .darkGray, width: 0.5)
        txtLoginPassword.addLine(position: .LINE_POSITION_BOTTOM, color: .darkGray, width: 0.5)
        lblErrorMess.isHidden = true
        
    }
    @IBAction func btnSendCode(_ sender: UIButton) {
        lblVerifyCodeMess.isHidden = false
    }
    @IBAction func btnSignUpClick(_ sender: UIButton) {
        performSegue(withIdentifier: "toSignUp", sender: self)
    }
    
    @IBAction func btnBackClick(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveLinear], animations:{
        self.viewLoginPanel.transform = CGAffineTransform(translationX: 0, y: 0)})
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveLinear], animations:{
            let x = -(self.viewForgetPanel.frame.width+7)
        self.viewForgetPanel.transform = CGAffineTransform(translationX: x, y: 0)})
    }
    
    @IBAction func btnForgetClick(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveLinear], animations:{
                   let x = self.viewLoginPanel.frame.width
               self.viewLoginPanel.transform = CGAffineTransform(translationX: x, y: 0)})
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveLinear], animations:{
                   let x = self.viewForgetPanel.frame.width+6
               self.viewForgetPanel.transform = CGAffineTransform(translationX: x, y: 0)})
    }
    @IBAction func btnLoginClick(_ sender: UIButton) {

        
        if(txtLoginUsername.text == "" || txtLoginPassword.text == ""){
            lblErrorMess.isHidden = false
        }else{
            AF.request(URL.init(string: "https://cuvfsx9pda.execute-api.us-east-1.amazonaws.com/aitoh/login")!, method: .post, parameters: ["username":txtLoginUsername.text! ,
                   "pwd_hash":txtLoginPassword.text!], encoding: JSONEncoding.default).responseJSON { (response) in

                       switch response.result {

                       case .success(let value):
                           let json = JSON(value)
                           
                           print(json)
                           if(json["loginSuccessful"].boolValue){
                            let viewController:TabViewController = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "TabViewController") as! TabViewController
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

                            // 返回 self.dismissViewControllerAnimated(true, completion: nil)
                            // save the presenting ViewController

                                        //傳至下一頁面
                            
                           }else{
                            self.lblErrorMess.isHidden = false
                           }
                           break
                       case .failure(let error):
                           print(error)
                           break
                       }
                   }
            
        }
        
       
        
        
       /* AF.request(url!).validate().responseJSON { (response) in
        switch response.result {
        case .success(let value):
         let json = JSON(value)
               let list = json["regions"].arrayValue

               for regionJson in list {
                   // 實例化一個 Book，並透過 bookJson 初始化它
                   let region = HotRegion(json: regionJson)
                   
                   self.hotRegionGroup.append(region)
               }
               let moreRegion = HotRegion(id: -1, name: "")
               self.hotRegionGroup.append(moreRegion)
             print(json)
         self.collectView.reloadData()
         break
            
        case .failure(let error):
            print(error)
        }*/
        
        
        
        
        
        
        
      /*  if(txtLoginUsername.text == "kevin.api" && txtLoginPassword.text == "happy1234"){
            UserDefaults.standard.set(txtLoginUsername.text, forKey: "username")
           
            
            
            
            
            
            
            UserDefaults.standard.set("1047", forKey: "userId")
            print(UserDefaults.standard.value(forKey: "username") ?? "test")
            print(UserDefaults.standard.value(forKey: "userId") ?? "test")

            // 返回 self.dismissViewControllerAnimated(true, completion: nil)
            // save the presenting ViewController

                        //傳至下一頁面
            let viewController:TabViewController = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "TabViewController") as! TabViewController
            viewController.modalPresentationStyle = .fullScreen
            let transition = CATransition()
            transition.duration = 0.3
            transition.type = CATransitionType.push
            transition.subtype = CATransitionSubtype.fromRight
            transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.linear)
            view.window!.layer.add(transition, forKey: kCATransition)
            
            self.present(viewController, animated: false, completion: nil)
        }else{
            lblErrorMess.isHidden = false
        }
 
 */
        
    }
    
}

