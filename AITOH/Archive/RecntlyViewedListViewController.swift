//
//  RecntlyViewedListViewController.swift
//  AITOH
//
//  Created by Jerry Kwok on 11/3/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RecntlyViewedListViewController: UIViewController {
    var recentViewList: [RecentView] = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let userId = UserDefaults.standard.string(forKey: "userId")
        guard let url = URL(string: "https://cuvfsx9pda.execute-api.us-east-1.amazonaws.com/aitoh/recentview?userId=" + userId!) else { return }
        print(url)
        createArray(gate: url)
        // Do any additional setup after loading the view.
    }
    
    
    func createArray(gate: URL){
        AF.request(gate).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
             let json = JSON(value)
             let list = json["recentViews"].arrayValue
             for recentViewJson in list {
                // 實例化一個 Book，並透過 bookJson 初始化它
                let recentView = RecentView(json: recentViewJson)
                self.recentViewList.append(recentView)
             }
             let recent = RecentView(id: -1, historyId: 1, iconImagePath: "https://aitohbucket.s3.amazonaws.com/tonyliu.jpg", content: "This is Region History", date: "Today")
             self.recentViewList.insert(recent, at: 0)
             print(self.recentViewList.count)
             print(json)
                 self.tableView.reloadData()
             
            
             break
                
            case .failure(let error):
                print(error)
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

extension RecntlyViewedListViewController:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentViewList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("setArray")
        let recentView = recentViewList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecentlyViewCell") as! RecentlyViewCell
        cell.initCommit(recent: recentView)
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let historyId = recentViewList[indexPath.row].historyId
        let userId = UserDefaults.standard.string(forKey: "userId")
        let history:History
        guard let getArchiveURL = URL(string: "https://cuvfsx9pda.execute-api.us-east-1.amazonaws.com/aitoh/archive?userId=" + userId! + "&historyId=" + String(historyId)) else { return }
        
        print(getArchiveURL)
        AF.request(getArchiveURL).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
             let json = JSON(value)
             print(json)
             let history = History(json: json)
             print("Click archive")
             
             if history.historyMediaPath == "" || history.historyMediaPath == " "{
                let  vc = (self.storyboard?.instantiateViewController(identifier: "ArchiveWatchTextViewController") as? ArchiveWatchTextViewController)!
                vc.history = history
                self.present(vc, animated: true, completion: nil)
             }else if history.mediaTypeId == 1{
                let vc = (self.storyboard?.instantiateViewController(identifier: "ArchiveWatchViewController") as? ArchiveWatchViewController)!
                vc.history = history
                self.present(vc, animated: true, completion: nil)
             }else{
                let vc = (self.storyboard?.instantiateViewController(identifier: "ArchiveWatchVideoViewController") as? ArchiveWatchVideoViewController)!
                vc.history = history
                self.present(vc, animated: true, completion: nil)
             }
             
             
            
             break
                
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
