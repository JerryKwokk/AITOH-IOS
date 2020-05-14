//
//  ArchiveListViewController.swift
//  AITOH
//
//  Created by Jerry Kwok on 11/3/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ArchiveListViewController: UIViewController {

    var archives: [Archive] = []
    var history: History!
    @IBOutlet weak var tableView: UITableView!
    lazy var refeshControl: UIRefreshControl = {
        let refeshControl = UIRefreshControl()
        refeshControl.tintColor = .gray
        refeshControl.addTarget(self, action: #selector(requestData), for: .valueChanged)
        return refeshControl
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("archiveList")
        let userId = UserDefaults.standard.string(forKey: "userId")
        guard let url = URL(string: "https://cuvfsx9pda.execute-api.us-east-1.amazonaws.com/aitoh/archive?userId=" + userId!) else { return }
        print(url)
        createArray(gate: url)
        tableView.refreshControl = refeshControl
        // Do any additional setup after loading the view.
    }
    
    @objc func requestData(){
         print("refesh data")
         let refeshDead = DispatchTime.now() + .milliseconds(900)
         DispatchQueue.main.asyncAfter(deadline: refeshDead){
            let currentDate = Date()
            let dataFormatter = DateFormatter() //實體化日期格式化物件
            dataFormatter.locale = Locale(identifier: "zh_Hant_TW")
            dataFormatter.dateFormat = "YYYY-MM-dd" //參照ISO8601的規則
            let stringDate = dataFormatter.string(from: currentDate)
             let arch = Archive(id: -1, historyId: -1, iconImagePath: "https://aitohbucket.s3.amazonaws.com/regionicon.jpg", content: "This is Region History", date: "Today")
            let hist = History(id: 101, description: "This is Region History", create_date: stringDate, location: "Devil's Peak Top Battery", username: "tonyliu43", userId: 1090, user_iconPath: "https://aitohbucket.s3.amazonaws.com/regionicon.jpg", historyMediaId: -1, historyMediaPath: "https://aitohbucket.s3.amazonaws.com/region-Group.jpg", mediaTypeId: 1)
            self.history = hist
            self.archives.insert(arch, at: 0)
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
    
    func createArray(gate: URL){
        AF.request(gate).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
             let json = JSON(value)
             let list = json["archives"].arrayValue
             for archiveJson in list {
                // 實例化一個 Book，並透過 bookJson 初始化它
                let archive = Archive(json: archiveJson)
                self.archives.append(archive)
             }
             print(self.archives.count)
             print(json)
                 self.tableView.reloadData()
             
            
             break
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
}
    


extension ArchiveListViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return archives.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("setArray")
        let archive = archives[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArchiveCell") as! ArchiveCell
        cell.initCommit(archive: archive)
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        let historyId = archives[indexPath.row].historyId
        if historyId != -1{
        let userId = UserDefaults.standard.string(forKey: "userId")
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
        }else{
            let vc = storyboard!.instantiateViewController(identifier: "ArchiveWatchViewController") as? ArchiveWatchViewController
            vc?.history = history
            self.present(vc!, animated: true, completion: nil)
        }
        
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            archives.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
