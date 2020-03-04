//
//  LocationHomeViewController.swift
//  AITOH
//
//  Created by Jerry Kwok on 2/3/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class LocationHomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var regions: [Region] = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
       guard let url = URL(string: "https://cuvfsx9pda.execute-api.us-east-1.amazonaws.com/aitoh/region") else { return }
       tableView.rowHeight = 225
       tableView.estimatedRowHeight = 0
       AF.request(url).validate().responseJSON { (response) in
           switch response.result {
           case .success(let value):
            let json = JSON(value)
                  // 獲取我們 list Array
                  let list = json["regions"].arrayValue
                  // 創建一個 [Book] 來存放獲取的 Array
                  for regionJson in list {
                      // 實例化一個 Book，並透過 bookJson 初始化它
                      let region = Region(json: regionJson)
                      // 加到上面 books 中
                      self.regions.append(region)
                  }
            
                print(json)
            print(self.regions.count)
            self.tableView.reloadData()
            break
               
           case .failure(let error):
               print(error)
           }
       }
       
        
        let nibName = UINib(nibName: "LocationHomeTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "LocationHomeTableViewCell")
        
        
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return regions.count
        
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let region = regions[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationHomeTableViewCell")as! LocationHomeTableViewCell
        cell.initCommit(region: region)
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
       {
        let region = regions[indexPath.row]
        let storyboard = UIStoryboard(name: "Region", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "RegionGroupDashboardViewController")as! RegionGroupDashboardViewController
        controller.region = region
        print("case1: ")
        self.present(controller, animated: true, completion: nil)


       }
    


}
