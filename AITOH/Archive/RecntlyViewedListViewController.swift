//
//  RecntlyViewedListViewController.swift
//  AITOH
//
//  Created by Jerry Kwok on 11/3/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit

class RecntlyViewedListViewController: UIViewController {
    var recentViewList: [RecebtView] = []
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

extension RecntlyViewedListViewController:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentViewList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("setArray")
        let recentView = recentViewList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecentlyViewCell") as! RecentlyViewCell
        cell.initCommit(archive: recentView)
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let vc = storyboard?.instantiateViewController(identifier: "ArchiveWatchViewController") as? ArchiveWatchViewController
        vc?.id = recentViewList[indexPath.row].historyId
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
