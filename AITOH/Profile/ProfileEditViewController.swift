//
//  ProfileEditViewController.swift
//  AITOH
//
//  Created by Jerry Kwok on 23/2/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit

class ProfileEditViewController: UIViewController {
    var config = YPImagePickerConfiguration()
    var selectPhoto:UIImage!
    var selected:Bool = false
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var fName: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var desc: UITextField!
    @IBOutlet weak var website: UITextField!
    @IBOutlet weak var email: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUI()
        loadUserData()
        // Do any additional setup after loading the view.
    }
    
    func loadUserData(){
        icon.image = UIImage(named: "profileIconImage.png")
        fName.text = "Kevin"
        username.text = "kevin.api"
        desc.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
        website.text = ""
        email.text = "68231423"
    }
    
    func loadUI(){
        icon.round()
        fName.loginFormat()
        username.loginFormat()
        desc.loginFormat()
        website.loginFormat()
        email.loginFormat()
    }
    @IBAction func btnCancelClick(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSaveClick(_ sender: Any) {
        
        if username.text == "test.api" {
            let controller = UIAlertController(title: "Username Failed", message: "The username is repeat", preferredStyle: .alert)
              let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
              controller.addAction(okAction)
              present(controller, animated: true, completion: nil)
        }else{
           
            print("dismiss")
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    @IBAction func clickEditPhoto(_ sender: Any) {
        config.isScrollToChangeModesEnabled = false
        config.onlySquareImagesFromCamera = false
        config.usesFrontCamera = true
        config.showsPhotoFilters = false
        config.shouldSaveNewPicturesToAlbum = true
        config.albumName = "DefaultYPImagePickerAlbumName"
        config.startOnScreen = YPPickerScreen.library
        config.screens = [.library, .photo]
        config.showsCrop = .none
        config.targetImageSize = YPImageSize.original
        config.overlayView = UIView()
        config.hidesStatusBar = true
        config.library.onlySquare = true
        config.library.options = nil
        config.hidesBottomBar = false
        config.preferredStatusBarStyle = UIStatusBarStyle.darkContent
        config.maxCameraZoomFactor = 1.0
        let picker = YPImagePicker(configuration: config)
        picker.didFinishPicking { [unowned picker] items, _ in
            if let photo = items.singlePhoto {
             //   print(photo.image)
                
                self.selectPhoto = photo.image
                self.selected = true
            }
            
            
            picker.dismiss(animated: true, completion: nil)
            self.icon.image = self.selectPhoto
            
        }
        present(picker, animated: true, completion: nil)
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
