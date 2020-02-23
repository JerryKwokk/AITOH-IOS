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
        fName.text = ""
        username.text = "kevin.api"
        desc.text = ""
        website.text = ""
        email.text = "68231423"
    }
    
    func loadUI(){
        icon.round()
        fName.format()
        username.format()
        desc.format()
        website.format()
        email.format()
    }
    
    @IBAction func btnSaveClick(_ sender: Any) {
        
        if username.text == "test.api" {
            let controller = UIAlertController(title: "Username Failed", message: "The username is repeat", preferredStyle: .alert)
              let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
              controller.addAction(okAction)
              present(controller, animated: true, completion: nil)
        }else{
            if let presenter = presentedViewController as? ProfileViewController {
                if(selected){
                    presenter.iconImage.image = selectPhoto
                    presenter.descrip.text = desc.text
                    print("test")
                }else{
                    presenter.descrip.text = desc.text
                    print("test2")
                }
                
            }
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
