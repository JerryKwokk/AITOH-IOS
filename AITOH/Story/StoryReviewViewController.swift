//
//  StoryReviewViewController.swift
//  AITOH
//
//  Created by Jerry Kwok on 21/2/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit
import CoreLocation
class StoryReviewViewController: UIViewController{
    
    var photo: UIImage!
    //@IBOutlet weak var desc: UITextView!
    
    
  
    //@IBOutlet weak var photoSelected: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.navigationController != nil{
            self.navigationController!.isNavigationBarHidden = false
        }
     //   selectPhoto.image = photo
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnCancelClick(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func btnShareClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
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

extension StoryReviewViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "StoryMainCell") as! StoryMainCell
            cell.setSelectPhoto(image:photo)
            return cell
        }
        else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "StoryLocationCell") as! StoryLocationCell
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "StoryPrivacyCell") as! StoryPrivacyCell
            //set the data here
            return cell
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         if indexPath.row == 0 {
            return 300
         }
         else if indexPath.row == 1 {
            return 100
         }
         else {
            return 60
         }
     }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if indexPath.row == 1 {
            
            let vc = storyboard?.instantiateViewController(identifier: "LocationViewController") as? LocationViewController
            self.navigationController?.pushViewController(vc!, animated: true)
            
          
        }else if indexPath.row == 2{
            
            let vc = storyboard?.instantiateViewController(identifier: "PrivacyViewController") as? PrivacyViewController
                      self.navigationController?.pushViewController(vc!, animated: true)
            
        }
        
        
        
    }
    
    
    
}

