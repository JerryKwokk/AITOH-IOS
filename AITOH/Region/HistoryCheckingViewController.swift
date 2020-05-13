//
//  HistoryCheckingViewController.swift
//  AITOH
//
//  Created by Jerry Kwok on 14/5/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AWSS3

class HistoryCheckingViewController: UIViewController {

    var regionHistorys: [RegionHistory] = []
    var reviewVC: RegionGroupReviewHistoryViewController?
    var picker: YPImagePicker?
    override func viewDidLoad() {
        super.viewDidLoad()
        chechHistory()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnCancelClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        reviewVC?.dismiss(animated: true, completion: nil)
        picker?.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func btnSaveClick(_ sender: Any) {
        let controller = UIAlertController(title: "History Alert", message: "Do you still want to save the history", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Save", style: .default) { (_) in
            self.dismiss(animated: true, completion: nil)
            self.reviewVC?.dismiss(animated: true, completion: nil)
            self.picker?.dismiss(animated: true, completion: nil)
        }
        controller.addAction(okAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        controller.addAction(cancelAction)
        present(controller, animated: true, completion: nil)
    }
    func chechHistory(){
        let rh1 = RegionHistory(id: 0, userId: 1, username: "tonyliu43", userImagePath: "https://aitohbucket.s3.amazonaws.com/regionicon.jpg", date: "8:12AM", desc: "This is Region History", location: "Devil's Peak Top Battery", long: 0, lat: 0, historyImagePath: "https://aitohbucket.s3.amazonaws.com/region-Group.jpg")
        regionHistorys.append(rh1)
    }
    


}
extension HistoryCheckingViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        regionHistorys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let history = regionHistorys[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegionGroupHistoryCell")as! RegionGroupHistoryCell
        cell.initCommit(history: history)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 315
        
    }
    
    
}
