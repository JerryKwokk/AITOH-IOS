//
//  ProfileStoryViewController.swift
//  AITOH
//
//  Created by Jerry Kwok on 23/2/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit

class ProfileStoryViewController: UIViewController {

    var storys:[Story] = []
    var selectPhoto:UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func createArray() -> [Story]{
        let story = Story(id: "1", username: "kevin.api", icon: UIImage(named: "profileIconImage.png")!, iconPath: "null", desc: "123", time: "10 seconds after", location: "Tseung Kwan O, Hong Kong", img: selectPhoto, imgPath: "null")
        
        return [story]
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

extension ProfileStoryViewController: UITableViewDataSource, UITableViewDelegate{



    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storys.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("setArray")
        let story = storys[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileStoryCell") as! ProfileStoryCell
        cell.setup(story: story)
        
        return cell
    }

    /*func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
    }*/
}
