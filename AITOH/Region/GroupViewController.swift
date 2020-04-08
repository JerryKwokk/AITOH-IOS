//
//  GroupViewController.swift
//  AITOH
//
//  Created by Jerry Kwok on 7/4/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit

class GroupViewController: UIViewController {

    var regionGroup: RegionGroup?
    var historys:[RegionHistory] = []
    @IBOutlet weak var textVIew: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

}
extension GroupViewController:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historys.count + 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 1){
            let cell = tableView.dequeueReusableCell(withIdentifier: "RegionGroupBackgroundCell", for: indexPath)as! RegionGroupBackgroundCell
            cell.setImage(imagePath: regionGroup!.bgImagePath)
            return cell
            
        }else if (indexPath.row == 2){
            let cell = tableView.dequeueReusableCell(withIdentifier: "RegionGroupTitleCell", for: indexPath)as! RegionGroupTitleCell
            cell.setDetial(title: regionGroup!.name, policy: true, member: 3)
            cell.viewController = self
                       return cell
            
        }else if (indexPath.row == 3 ){
            let cell = tableView.dequeueReusableCell(withIdentifier: "RegionGroupNewHistoryCell", for: indexPath)as! RegionGroupNewHistoryCell
            cell.setIcon()
            return cell
            
        }else {
           let history = historys[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "RegionGroupNewHistoryCell") as! RegionGroupHistoryCell
            cell.initCommit(history: history)
            return cell
        }
    }
    
   
    
}
