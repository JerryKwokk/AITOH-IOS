//
//  RegionGroupReviewHistoryViewController.swift
//  AITOH
//
//  Created by Jerry Kwok on 13/5/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RegionGroupReviewHistoryViewController: UIViewController {

    var photo: UIImage!
    var picker: YPImagePicker!
    var locations: [Location]!
    var checkList: [History]! = []
    @IBOutlet weak var process: UIProgressView!
    let time: Float = 6.0
    var ct: Float = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        locations = createArray()
        process.transform = process.transform.scaledBy(x: 1, y: 1)
               process.setProgress(0.0, animated: false)
               process.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    func createArray() -> [Location]{
        let loca1 = Location(id: 1, place: "Hong Kong", lat: 0.0, long: 0.0)
        let loca2 = Location(id: 2, place: "METRO", lat: 0.0, long: 0.0)
        return [loca1, loca2]
    }
    
    func convertToBase64(image: UIImage) -> String {
        return image.pngData()!
            .base64EncodedString()
    }
    
    @IBAction func btnSaveClick(_ sender: Any) {
        
        AF.request(URL.init(string: "https://cuvfsx9pdb.execute-api.us-east-1.amazonaws.com/aitoh/upload")!, method: .post, parameters: ["Image":
            convertToBase64(image: photo)], encoding: JSONEncoding.default).responseJSON { (response) in

            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let list = json["historys"].arrayValue
                for history in list {
                    let history = History(json: history)
                    self.checkList.append(history)
                }
                
                break
            case .failure(let error):
                print(error)
                break
            }
        }
        process.isHidden = false
        process.setProgress(ct, animated: true)
         perform(#selector(performAction), with: nil, afterDelay: 1.0)
        
        
    }
    
    @objc func performAction(){
           ct = ct + 1.0
           process.progress = ct/time
           if ct < time{
               perform(#selector(performAction), with: nil, afterDelay: 1.0)
           }else{
            let vc = storyboard!.instantiateViewController(identifier: "HistoryCheckingViewController") as!HistoryCheckingViewController
            vc.reviewVC = self
            vc.picker = picker
            self.present(vc, animated: true)
            
               ct = 0.0
           }
       }
    
    @IBAction func btnCancelClick(_ sender: Any) {
        picker.dismiss(animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
        
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

extension RegionGroupReviewHistoryViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RegionGroupHistoryReviewCell") as! RegionGroupHistoryReviewCell
            cell.setSelectPhoto(image:photo)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "RegionGroupReviewLocationCell") as! RegionGroupReviewLocationCell
            cell.loadLocation(locations: locations)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
           return 290
        }
        else{
           return 130
        }
        
    }
    
    
}
