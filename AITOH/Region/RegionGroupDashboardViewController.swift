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
    
    var region:Region?
    var hotRegionGroup:[HotRegion] = []
    @IBOutlet weak var collectView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        print("case1: " + region!.bgImagePath!)
        guard let url = URL(string: "https://cuvfsx9pda.execute-api.us-east-1.amazonaws.com/aitoh/regiongroup?hot=true&regionId=" + String(region!.id!)) else { return }
        print(url)
        getHotRegionGroup(gate: url)

    }
    
    func getHotRegionGroup(gate: URL){
        AF.request(gate).validate().responseJSON { (response) in
            switch response.result {
            case .success(let value):
             let json = JSON(value)
                   let list = json["regions"].arrayValue

                   for regionJson in list {
                       // 實例化一個 Book，並透過 bookJson 初始化它
                       let region = HotRegion(json: regionJson)
                       
                       self.hotRegionGroup.append(region)
                   }
                   let moreRegion = HotRegion(id: -1, name: "")
                   self.hotRegionGroup.append(moreRegion)
                 print(json)
             self.collectView.reloadData()
             break
                
            case .failure(let error):
                print(error)
            }
        }
            
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hotRegionGroup.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
            let regionGroup = hotRegionGroup[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HotRegionGroupCell", for: indexPath)as! HotRegionGroupCell
             if(indexPath.row == hotRegionGroup.count - 1){
                cell.initLast()
             }else{
                cell.initElement(region: regionGroup)
             }
            
            return cell
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 200)
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
