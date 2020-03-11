//
//  RegionGroupDashboardViewController.swift
//  AITOH
//
//  Created by Jerry Kwok on 4/3/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RegionGroupDashboardViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var historyCollectionView: UICollectionView!
    var region:Region?
    var hotRegionGroup:[HotRegion] = []
    var privateRegionGroup:[PrivateRegion] = []
    var regionGroupHistory:[RegionHistory] = []
    @IBOutlet weak var collectView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let userId:String = UserDefaults.standard.string(forKey: "userId")!
        // Do any additional setup after loading the view.
        print("case1: " + region!.bgImagePath!)
        guard let url = URL(string: "https://cuvfsx9pda.execute-api.us-east-1.amazonaws.com/aitoh/regiongroup?hot=true&regionId=" + String(region!.id!)+"&userId=" + userId) else { return }
        print(url)
        getHotRegionGroup(gate: url)
    }
    
    @IBAction func btnClose(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func getHotRegionGroup(gate: URL){
        AF.request(gate).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
             let json = JSON(value)
             let list = json["regions"].arrayValue
             let priList = json["privateRegion"].arrayValue
             let history = json["history"].arrayValue
             for regionJson in list {
                // 實例化一個 Book，並透過 bookJson 初始化它
                let region = HotRegion(json: regionJson)
                self.hotRegionGroup.append(region)
             }
             let moreRegion = HotRegion(id: -1, name: "")
             self.hotRegionGroup.append(moreRegion)
             print(json)
             self.collectView.reloadData()
             for priRegionJson in priList{
                let priRegion = PrivateRegion(json: priRegionJson)
                self.privateRegionGroup.append(priRegion)
             }
             self.tableView.reloadData()
             for hist in history{
                let hotRegionHist = RegionHistory(json: hist)
                self.regionGroupHistory.append(hotRegionHist)
             }
             self.historyCollectionView.reloadData()
             break
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == self.collectView){
            return hotRegionGroup.count
        }else{
            return regionGroupHistory.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView != self.historyCollectionView){
            print("load model indr" + String(indexPath.row))
            let regionGroup = hotRegionGroup[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HotRegionGroupCell", for: indexPath)as! HotRegionGroupCell
            print(hotRegionGroup.count)
             if(indexPath.row == hotRegionGroup.count - 1){
                cell.initLast()
             }else{
                cell.initElement(region: regionGroup)
             }
            
            return cell
        }else{
            print("print history")
            let hist = regionGroupHistory[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HotRegionHistoryCell", for: indexPath)as! HotRegionHistoryCell
            cell.initCommit(region: hist)
            
            return cell
        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(collectionView == self.collectView){
            return CGSize(width: 100, height: 200)
        }else{
            return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
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

extension RegionGroupDashboardViewController: UICollectionViewDelegateFlowLayout {

}

extension RegionGroupDashboardViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(privateRegionGroup.count > 2){
            return 0
        }else{
            return privateRegionGroup.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let privateRegion = privateRegionGroup[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "PrivateGroupTableViewCell", for: indexPath)as! PrivateGroupTableViewCell
        cell.initCommit(region: privateRegion)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

}


