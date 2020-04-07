//
//  RegionGroupSearchViewController.swift
//  AITOH
//
//  Created by Jerry Kwok on 5/4/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RegionGroupSearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    var regionGroup:[RegionGroup] = []
    var searchRegionGroup:[RegionGroup] = []
    var regionId: Int!
    var searching = false
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        createArray()
        loadUI()
        // Do any additional setup after loading the view.
    }
    func loadUI(){
        //searchBar.layer.borderColor = UIColor.darkGray.cgColor
        //searchBar.layer.borderWidth = 1
        //searchBar.layer.cornerRadius = 20.0
        searchBar.clipsToBounds = true
        searchBar.barTintColor = .white
    }
    @IBAction func btnBackClick(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        self.view.window!.layer.add(transition, forKey: nil)
        dismiss(animated: true, completion: nil)
    }
    
    func createArray(){
        AF.request(URL.init(string: "https://cuvfsx9pda.execute-api.us-east-1.amazonaws.com/aitoh/regiongroup?regionId=" + String(regionId))!, method: .get, encoding: JSONEncoding.default).responseJSON { (response) in

                           switch response.result {
                           case .success(let value):
                               let json = JSON(value)
                               
                               print(json)
                               let list = json["regions"].arrayValue
                               for item in list {
                                let region = RegionGroup(json: item)
                                self.regionGroup.append(region)
                               }
                               self.tableView.reloadData()
                               break
                           case .failure(let error):
                               print(error)
                               break
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
extension RegionGroupSearchViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searching){
            return searchRegionGroup.count
        }else{
            return regionGroup.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var region: RegionGroup
        if searching {
            region = searchRegionGroup[indexPath.row]
        }else{
            region = regionGroup[indexPath.row]
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReginGroupSearchCell") as! ReginGroupSearchCell
        cell.initCommit(rg: region)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
extension RegionGroupSearchViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" || searchText == " " {
            searching = false
        }else{
            searchRegionGroup.removeAll()
            for item in regionGroup {
                if(item.name.uppercased().contains(searchText.uppercased())){
                    searchRegionGroup.append(item)
                }
            }
            searching = true
        }
        
        tableView.reloadData()
        
        
    }
}
