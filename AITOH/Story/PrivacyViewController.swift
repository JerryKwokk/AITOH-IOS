//
//  PrivacyViewController.swift
//  AITOH
//
//  Created by Jerry Kwok on 22/2/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit

class PrivacyViewController: UIViewController {

    var privacyList:[Privacy] = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        privacyList = creatArray()
        // Do any additional setup after loading the view.
    }
    
    func creatArray() -> [Privacy]{
        let privacyPublic = Privacy(id: "1", title: "Public", icon: UIImage(named: "baseline_public_black_48pt_3x.png")!, subtitle: "")
        let privacyPrivate = Privacy(id: "2", title: "Private", icon: UIImage(named: "baseline_lock_black_48pt_3x.png")!, subtitle: "")
        
        return [privacyPublic, privacyPrivate]
        
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

extension PrivacyViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return privacyList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("setArray")
        let privacy = privacyList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "PrivacyCell") as! PrivacyCell
        
        cell.setPrivacy(privacy: privacy)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

   

}
