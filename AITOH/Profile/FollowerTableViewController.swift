//
//  FollowerTableViewController.swift
//  AITOH
//
//  Created by Jerry Kwok on 21/2/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit

class FollowerTableViewController: UIViewController {
    
    var users: [User] = []
    @IBOutlet weak var textView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        users = createArray()
        textView.separatorStyle = .none
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func createArray() -> [User] {
        let user1 = User(id: "1", username: "user0001", fname: "", userIcon: UIImage(named: "icon1.png")!, userIconPath: "null")
        let user2 = User(id: "2", username: "fellow.01", fname: "", userIcon: UIImage(named: "icon2.png")!, userIconPath: "null")
        let user3 = User(id: "3", username: "jerrykhh", fname: "Jerry Kwok", userIcon: UIImage(named: "default.png")!, userIconPath: "null")
        let user4 = User(id: "4", username: "karca", fname: "Karca Kwok", userIcon: UIImage(named: "default.png")!, userIconPath: "null")
        let user5 = User(id: "5", username: "alex", fname: "Alex Ng", userIcon: UIImage(named: "default.png")!, userIconPath: "null")
        let user6 = User(id: "6", username: "helloworld", fname: "World", userIcon: UIImage(named: "default.png")!, userIconPath: "null")
        
        return [user1,user2,user3,user4,user5,user6]
    }

}

extension FollowerTableViewController: UITableViewDataSource, UITableViewDelegate{
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("setArray")
        let user = users[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell") as! FollowerTableViewCell
        cell.setUser(user: user)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
    }


    

    

}
