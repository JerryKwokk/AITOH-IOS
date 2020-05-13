//
//  GroupViewController.swift
//  AITOH
//
//  Created by Jerry Kwok on 7/4/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import YPImagePicker

class GroupViewController: UIViewController {

    var regionGroup: RegionGroup?
    var historys:[RegionHistory] = []
    var config:YPImagePickerConfiguration!
    @IBOutlet weak var tableView: UITableView!
    lazy var refeshControl: UIRefreshControl = {
           let refeshControl = UIRefreshControl()
           refeshControl.tintColor = .gray
           refeshControl.addTarget(self, action: #selector(requestData), for: .valueChanged)
           return refeshControl
       }()
    
    
    @IBOutlet weak var textVIew: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(regionGroup)
        createArray()
        
        tableView.refreshControl = refeshControl
        // Do any additional setup after loading the view.
    }
    
    func createArray(){
        config = YPImagePickerConfiguration()
        let rh1 = RegionHistory(id: 0, userId: 1, username: "tonyliu43", userImagePath: "https://aitohbucket.s3.amazonaws.com/regionicon.jpg", date: "8:12AM", desc: "This is Region History", location: "Devil's Peak Top Battery", long: 0, lat: 0, historyImagePath: "https://aitohbucket.s3.amazonaws.com/region-Group.jpg")
        historys.append(rh1)
        guard let getRegionURL = URL(string: "https://cuvfsx9pdb.execute-api.us-east-1.amazonaws.com/test/regionGroup?regionGroupId="+String(regionGroup!.id)) else { return }
        AF.request(getRegionURL).validate().responseJSON { (response) in
                   switch response.result {
                   case .success(let value):
                    let json = JSON(value)
                    let list = json["regionHistorys"].arrayValue
                    for historyJson in list {
                        let hist = RegionHistory(json: historyJson)
                        
                        self.historys.append(hist)
                    }
                    
                   
                    break
                       
                   case .failure(let error):
                       print(error)
                   }
        
    }
    }
    @IBAction func btnCancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func requestData(){
        print("refesh data")
        let refeshDead = DispatchTime.now() + .milliseconds(900)
        DispatchQueue.main.asyncAfter(deadline: refeshDead){
            let currentDate = Date()
            let dataFormatter = DateFormatter() //實體化日期格式化物件
            dataFormatter.locale = Locale(identifier: "zh_Hant_TW")
            dataFormatter.dateFormat = "YYYY-MM-dd"
            let rh0 = RegionHistory(id: 0, userId: 1047, username: "kevin.api", userImagePath: "https://aitohbucket.s3.amazonaws.com/kevin.jpg", date: "Now", desc: "This is Region History", location: "Hong Kong", long: 0, lat: 0, historyImagePath: "https://aitohbucket.s3.amazonaws.com/region-Group.jpg")
            self.historys.insert(rh0, at: 0)
            self.tableView.reloadData()
            self.refeshControl.endRefreshing()
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
extension GroupViewController:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historys.count + 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "RegionGroupBackgroundCell", for: indexPath)as! RegionGroupBackgroundCell
            cell.setImage(imagePath: regionGroup!.bgImagePath)
            return cell
            
        }else if (indexPath.row == 1){
            let cell = tableView.dequeueReusableCell(withIdentifier: "RegionGroupTitleCell", for: indexPath)as! RegionGroupTitleCell
            cell.setDetial(title: regionGroup!.name, policy: true, member: 3)
            cell.viewController = self
                       return cell
            
        }else if (indexPath.row == 2 ){
            let cell = tableView.dequeueReusableCell(withIdentifier: "RegionGroupNewHistoryCell", for: indexPath)as! RegionGroupNewHistoryCell
            cell.setIcon()
            return cell
            
        }else {
            print(historys.count)
            print(indexPath.row)
               let history = historys[indexPath.row - 3]
                let cell = tableView.dequeueReusableCell(withIdentifier: "RegionGroupHistoryCell") as! RegionGroupHistoryCell
                cell.initCommit(history: history)
                return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 201
        }else if indexPath.row == 1 {
            return 150
        }else if indexPath.row == 2{
            return 99
        }else{
            return 260
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2{
            let vc = storyboard!.instantiateViewController(identifier: "RegionGroupReviewHistoryViewController") as? RegionGroupReviewHistoryViewController
            config.isScrollToChangeModesEnabled = true
            config.onlySquareImagesFromCamera = false
            config.usesFrontCamera = true
            config.showsPhotoFilters = false
            config.showsVideoTrimmer = true
            config.shouldSaveNewPicturesToAlbum = true
            config.albumName = "AITOH"
            config.startOnScreen = YPPickerScreen.photo
            config.screens = [.library, .photo, .video, .audioVC]
            config.showsCrop = .none
            config.targetImageSize = YPImageSize.original
            config.overlayView = UIView()
            config.hidesStatusBar = true
            config.hidesBottomBar = false
            config.preferredStatusBarStyle = UIStatusBarStyle.darkContent
            config.maxCameraZoomFactor = 1.0
            config.wordings.next = "Next"
            let picker = YPImagePicker(configuration: config)
            picker.didFinishPicking { [unowned picker] items, cancelled in
                if cancelled {
                    picker.dismiss(animated: true, completion: nil)
                    return
                }
                if let photo = items.singlePhoto {
                 //   print(photo.image)
                    
                    vc?.photo = photo.image
                    vc?.picker = picker
                    print(photo)
                    picker.present(vc!, animated: true)
                }
                
                //picker.dismiss(animated: true, completion: nil)
                
            }
            present(picker, animated: true, completion: nil)
        }
    }
    
   
}

