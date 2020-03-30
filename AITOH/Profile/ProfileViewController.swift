//
//  ProfileViewController.swift
//  AITOH
//
//  Created by Jerry Kwok on 17/2/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    var storys:[Story] = []
      var user: UserProfile!
    @IBOutlet weak var tableView: UITableView!
    lazy var refeshControl: UIRefreshControl = {
        let refeshControl = UIRefreshControl()
        refeshControl.tintColor = .gray
        refeshControl.addTarget(self, action: #selector(requestData), for: .valueChanged)
        return refeshControl
    }()

    override func viewDidLoad() {
          super.viewDidLoad()
          storys = createArray()
          user = createUser()
          tableView.separatorStyle = .none
        
          tableView.refreshControl = refeshControl
        //navigationController?.hidesBarsOnTap = true
        // Do any additional setup after loading the view.
      }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.navigationController?.navigationBar.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    }
    
    @objc func requestData(){
        print("refesh data")
        let refeshDead = DispatchTime.now() + .milliseconds(900)
        DispatchQueue.main.asyncAfter(deadline: refeshDead){
            self.refeshControl.endRefreshing()
        }
    }
   
    

      func createArray() -> [Story]{
          let story = Story(id: "1", username: "kevin.api", icon: UIImage(named: "profileIconImage.png")!, iconPath: "null", desc: "I am sad", time: "3 seconds before", location: "Tseung Kwan O, Hong Kong", img: UIImage(named: "profileIconImage.png")!, imgPath: "null")
          
          return [story]
      }
      func createUser() -> UserProfile{
          let kevin = UserProfile(userId: "1", username: "kevin.api", privacy: true, follower: 6, following: 12, desr: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", iconImage: UIImage(named:"profileIconImage.png" )!, bgImage: UIImage(named: "profileBackgroundImage.png")!)
          
          return kevin
      }
    

    

}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storys.count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileMainCell") as! ProfileMainCell
            cell.setup(user: user)
             return cell
        }else{
            print("setArray")
            let story = storys[indexPath.row - 1]
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileStoryCell") as! ProfileStoryCell
            cell.setup(story: story)
            
            return cell
        }
        
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 0){
            return 560
        }else{
            return 300
        }
        
    }
}

