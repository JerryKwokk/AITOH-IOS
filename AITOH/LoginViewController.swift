//
//  LoginViewController.swift
//  AITOH
//
//  Created by Jerry Kwok on 28/1/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit
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
        if(txtLoginUsername.text == "kevin.api" && txtLoginPassword.text == "happy1234"){
            
        }else{
            lblErrorMess.isHidden = false
        }
        
    }
    
}

