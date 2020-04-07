//
//  CreateRegionViewController.swift
//  AITOH
//
//  Created by Jerry Kwok on 7/4/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import DLRadioButton

class CreateRegionViewController: UIViewController, RadioButtonControllerDelegate {

    
    @IBOutlet weak var text: UITextField!
    @IBOutlet weak var btnPublic: DLRadioButton!
    
    @IBOutlet weak var ImageButton: UIButton!
    @IBOutlet weak var btnPrivate: DLRadioButton!
    @IBOutlet weak var searchBar: UISearchBar!
    var config = YPImagePickerConfiguration()
    var users:[SuggestedUser] = []
    var searchUser:[SuggestedUser] = []
    var searching = false
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func btnPublicClick(_ sender: Any) {
        if(btnPrivate.isSelected){
            btnPublic.isSelected = false
            btnPrivate.isSelected = true
        }
    }
    @IBAction func btnPrivateClick(_ sender: Any) {
        if(btnPublic.isSelected){
            btnPublic.isSelected = true
            btnPrivate.isSelected = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AF.request(URL.init(string: "https://cuvfsx9pda.execute-api.us-east-1.amazonaws.com/aitoh/activity?suggested=true&userId=" + UserDefaults.standard.string(forKey: "userId")!)!, method: .get, encoding: JSONEncoding.default).responseJSON { (response) in

                           switch response.result {
                           case .success(let value):
                               let json = JSON(value)
                               print(json)
                               let list = json["users"].arrayValue
                               for item in list {
                                let sugUser = SuggestedUser(json:item)
                                self.users.append(sugUser)
                               }
                               self.tableView.reloadData()
                               break
                           case .failure(let error):
                               print(error)
                               break
                           }
                       }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnImagePicker(_ sender: Any) {
        config.isScrollToChangeModesEnabled = true
               config.onlySquareImagesFromCamera = true
               config.showsPhotoFilters = false
               config.shouldSaveNewPicturesToAlbum = true
               config.albumName = "DefaultYPImagePickerAlbumName"
               config.startOnScreen = YPPickerScreen.photo
               config.screens = [.library]
               config.showsCrop = .none
               config.targetImageSize = YPImageSize.original
               config.overlayView = UIView()
               config.hidesStatusBar = true
               config.hidesBottomBar = true
               config.preferredStatusBarStyle = UIStatusBarStyle.darkContent
               config.maxCameraZoomFactor = 1.0
               config.wordings.next = "SELECT"
               let picker = YPImagePicker(configuration: config)
               picker.didFinishPicking { [unowned picker] items, _ in
                   if let photo = items.singlePhoto {
                       print(photo.image)
                       
                    self.ImageButton.setImage(photo.image, for: .normal)
                    
                      
                   }
                   
                   
                   picker.dismiss(animated: true, completion: nil)
               }
               present(picker, animated: true, completion: nil)
               // Do any additional setup after loading the view.
    }
    
    func didSelectedButton(_ radioButtonController: RadioButtonController, _ currentSelectedButton: RadioButton?) {
        print(currentSelectedButton as Any)
    }
    @IBAction func btnSaveClick(_ sender: Any) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: nil)
        self.dismiss(animated: false, completion: nil)
    }
    @IBAction func btnBackClick(_ sender: Any) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: nil)
        self.dismiss(animated: false, completion: nil)
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
extension CreateRegionViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" || searchText == " " {
            searching = false
        }else{
            searchUser.removeAll()
            for item in users {
                if(item.username.uppercased().contains(searchText.uppercased())){
                    searchUser.append(item)
                }
            }
            if(searchUser.count == 0){
                AF.request(URL.init(string: "https://cuvfsx9pda.execute-api.us-east-1.amazonaws.com/aitoh/user?keyword=true&username=" + searchText)!, method: .get, encoding: JSONEncoding.default).responseJSON { (response) in

                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        print(json)
                        let list = json["users"].arrayValue
                        for item in list {
                         let sugUser = SuggestedUser(json:item)
                         self.searchUser.append(sugUser)
                        }
                        self.tableView.reloadData()
                        break
                    case .failure(let error):
                        print(error)
                        break
                    }
                }
            }
            searching = true
        }
        
        tableView.reloadData()
        
        
    }
}

extension CreateRegionViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(!searching){
            return users.count
        }else{
            return searchUser.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !searching {
            let user = users[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "CreateRegionSearchCell", for: indexPath) as!CreateRegionSearchCell
            cell.initCommint(user: user)
            return cell
        }else{
            let user = searchUser[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "CreateRegionSearchCell", for: indexPath) as!CreateRegionSearchCell
            cell.initCommint(user: user)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 77
    }
    
    
    
    
}
