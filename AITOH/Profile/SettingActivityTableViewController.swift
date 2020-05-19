//
//  SettingActivityTableViewController.swift
//  AITOH
//
//  Created by Jerry Kwok on 22/2/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit
import Alamofire

class SettingActivityTableViewController: UIViewController {
    var deviceList:[Device] = []
    @IBOutlet var DeviceView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deviceList = createArray()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @IBAction func btnCancelClick(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func createArray() -> [Device]{
        let device = Device(name: UIDevice.modelName, loginTime: "2019-02-22", location: "Hong Kong")
        return [device]
    }

    // MARK: - Table view data source

}

extension SettingActivityTableViewController:UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return deviceList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return deviceList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let device = deviceList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingLoginActivityTableCell") as! SettingLoginActivityTableCell
        cell.setDevice(device: device)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = UIAlertController(title: "", message: "Device", preferredStyle: .actionSheet)
        let names = ["Logout"]
        for name in names {
            let action = UIAlertAction(title: name, style: .destructive) { (action) in
                let curDevice = self.deviceList[indexPath.row].name
                if curDevice == UIDevice.modelName {
                    let vc = self.storyboard!.instantiateViewController(identifier: "LoginViewController") as!LoginViewController
                    UserDefaults.standard.removeObject(forKey: "userId")
                    UserDefaults.standard.removeObject(forKey: "username")
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                    //self.dismiss(animated: true, completion: nil)
                }else{
                    
                }
                
           }
           controller.addAction(action)
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        controller.addAction(cancelAction)
        present(controller, animated: true, completion: nil)
    }
    
}
