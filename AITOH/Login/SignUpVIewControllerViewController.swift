//
//  SignUpVIewControllerViewController.swift
//  AITOH
//
//  Created by Jerry Kwok on 16/2/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit
import Alamofire

class SignUpViewControllerViewController: UIViewController {

    @IBOutlet weak var txtRegionCode: UITextField!
    
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtPwd: UITextField!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var lblErrorPhoneNo: UILabel!
    @IBOutlet weak var lblErrorFullName: UILabel!
    @IBOutlet weak var lblErrorUsername: UILabel!
    @IBOutlet weak var lblErrorPwd: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
        // Do any additional setup after loading the view.
    }
    
    func loadUI(){
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 0))
        let leftViewFullName = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 0))
        let leftViewPwd = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 0))
        txtUsername.borderStyle = UITextField.BorderStyle.roundedRect
        txtUsername.leftView = leftView
        txtUsername.leftViewMode = .always
        txtFullName.borderStyle = UITextField.BorderStyle.roundedRect
        txtPwd.borderStyle = UITextField.BorderStyle.roundedRect
        txtFullName.leftView = leftViewFullName
        txtPwd.leftView = leftViewPwd
        txtFullName.leftViewMode = .always
        txtPwd.leftViewMode = .always
        btnSignUp.layer.cornerRadius = 5
        lblErrorPwd.isHidden = true
        lblErrorUsername.isHidden = true
        lblErrorFullName.isHidden = true
        lblErrorPwd.isHidden = true
        lblErrorPhoneNo.isHidden = true
    }
    @IBAction func btnSignUpClick(_ sender: UIButton) {
        var checkInput:Bool = false;
        if(txtRegionCode.text == "" || txtPhone.text == ""){
            lblErrorPhoneNo.text = "Phone number is required"
            lblErrorPhoneNo.isHidden = false
            checkInput = true
        }
        if(txtFullName.text == ""){
            lblErrorFullName.isHidden = false;
            checkInput = true
        }
        if(txtUsername.text == ""){
            lblErrorUsername.text = "Username is required"
            lblErrorUsername.isHidden = false
            checkInput = true
        }
        if(txtPwd.text == ""){
            lblErrorPwd.isHidden = false
            checkInput = true
        }
        
        if(!checkInput){
            /*
             
               AF.request(URL.init(string: "https://cuvfsx9pda.execute-api.us-east-1.amazonaws.com/aitoh/login")!, method: .post, parameters: ["username": txtUsername.text, "tel": txtRegionCode.text + txtPhone.text, "fullName": txtFullName.text, "pwd_hash": txtPwd.text, regionId: 1, suspensionStatusId: 1], encoding: JSONEncoding.default).responseJSON { (response) in

                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        print(json)
                        if !json["verify"].boolValue {
                            self.resendMes.text = "The verify is wrong"
                            self.resendMes.textColor = .red
                        }
                        break
                    case .failure(let error):
                        print(error)
                        break
                    }
                }
             
             */
             let storyboard = UIStoryboard(name: "Signup", bundle: nil)
                       let vc = storyboard.instantiateViewController(withIdentifier: "VerifyAccountViewController") as! VerifyAccountViewController
            vc.user = User(username: txtUsername.text!, fname: txtFullName.text!, phone: txtRegionCode.text! + txtPhone.text!, password: txtPwd.text!)
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func btnLoginClick(_ sender: UIButton) {
        weak var pvc = self.presentingViewController

        self.dismiss(animated: true)
        
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
