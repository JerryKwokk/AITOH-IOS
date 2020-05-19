//
//  ProfileViewController.swift
//  AITOH
//
//  Created by Jerry Kwok on 17/2/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

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
    var count = 0
    
    @objc func requestData(){
        print("refesh data")
        let refeshDead = DispatchTime.now() + .milliseconds(900)
        DispatchQueue.main.asyncAfter(deadline: refeshDead){
            if self.count == 0 {
                let currentDate = Date()
                let dataFormatter = DateFormatter() //實體化日期格式化物件
                let userCalendar = Calendar.current
                let requestedComponents: Set<Calendar.Component> = [
                    .hour,
                    .minute
                ]
                let dateTimeComponents = userCalendar.dateComponents(requestedComponents, from: currentDate)
                let hour = dateTimeComponents.hour   // 22
                var min = dateTimeComponents.minute
                min = min! - 1
                dataFormatter.timeStyle = .medium
                dataFormatter.dateStyle = .none
                let curtimes = dataFormatter.string(from: currentDate)
                let curtime = String(hour!) + ":" + String(format: "%02d", min!) + "PM"
                dataFormatter.locale = Locale(identifier: "zh_Hant_TW")
                dataFormatter.dateFormat = "YYYY-MM-dd"
                
                let stringDate = dataFormatter.string(from: currentDate)
                let story = Story(id: "2", username: "kevin.api", icon: UIImage(named: "profileIconImage.png")!, iconPath: "null", desc: stringDate, time: curtime, location: "", img: UIImage(named: "wd")!, imgPath: "null", media: "image/mp4")
                self.storys.insert(story, at: 0)
            }else{
                let userEdit = UserProfile(userId: "1", username: "kevin.api", privacy: true, follower: 6, following: 12, desr: "Testing Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", iconImage: UIImage(named:"icon-res.jpg" )!, bgImage: UIImage(named: "profileBackgroundImage.png")!)
                self.user = userEdit
                var countArray = 0
                for _ in self.storys{
                    self.storys[countArray].icon = UIImage(named:"icon-res.jpg" )!
                    countArray = countArray + 1
                }
            }
            self.tableView.reloadData()
            self.count = self.count + 1
            
            self.refeshControl.endRefreshing()
        }
    }
   
    

      func createArray() -> [Story]{
          let story = Story(id: "1", username: "kevin.api", icon: UIImage(named: "profileIconImage.png")!, iconPath: "null", desc: "I am sad", time: "00:25AM", location: "Tseung Kwan O, Hong Kong", img: UIImage(named: "profileIconImage.png")!, imgPath: "null", media: "image/jpg")
          
          return [story]
      }
      func createUser() -> UserProfile{
          let kevin = UserProfile(userId: "1", username: "kevin.api", privacy: true, follower: 2, following: 12, desr: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.", iconImage: UIImage(named:"profileIconImage.png" )!, bgImage: UIImage(named: "profileBackgroundImage.png")!)
          
          return kevin
      }
    

    

}

extension ProfileViewController: VideoCellDelegates{
    func btnClickPlay() {
        print("sdf")
        if let path = Bundle.main.path(forResource: "video", ofType: "mp4"){
            let video = AVPlayer(url: URL(fileURLWithPath: path))
            let videoPlayer = AVPlayerViewController()
            videoPlayer.player = video
            
            present(videoPlayer, animated: true, completion: video.play)
        }
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
            if story.media == "image/jpg"{
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileStoryCell") as! ProfileStoryCell
                cell.setup(story: story)
                return cell
                
            }else{
                print("good")
                let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileStoryVoiceCell") as! ProfileStoryVoiceCell
                cell.setup(story: story)
                cell.delegate = self
                cell.btnPlayClick.addTarget(self, action: #selector(playClick(sender:)), for: .touchUpInside)
                cell.isUserInteractionEnabled = true
                print("ok")
                return cell
                
            }
            
        }
        
        
    }
    
    @objc func playClick(sender: UIButton){
        print("click")
        if let path = Bundle.main.path(forResource: "video", ofType: "mp4"){
            let video = AVPlayer(url: URL(fileURLWithPath: path))
            let videoPlayer = AVPlayerViewController()
            videoPlayer.player = video
            
            self.present(videoPlayer, animated: true, completion: video.play)
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
         if(indexPath.row != 0){
            let story = storys[indexPath.row - 1]
            if story.media != "image/jpg"{
                guard let path = Bundle.main.path(forResource: "video", ofType:"mp4") else {
                    debugPrint("video.m4v not found")
                    return
                }
                let player = AVPlayer(url: URL(fileURLWithPath: path))
                let playerController = AVPlayerViewController()
                playerController.player = player
                present(playerController, animated: true) {
                    player.play()
                }
            }
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


