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
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("archiveList")
        let userId = UserDefaults.standard.string(forKey: "userId")
        guard let url = URL(string: "https://cuvfsx9pda.execute-api.us-east-1.amazonaws.com/aitoh/archive?userId=" + userId!) else { return }
        print(url)
        createArray(gate: url)
        
        // Do any additional setup after loading the view.
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
        let vc = storyboard?.instantiateViewController(identifier: "ArchiveWatchViewController") as? ArchiveWatchViewController
        vc?.id = archives[indexPath.row].historyId
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
