//
//  HistoryDetialsViewController.swift
//  AITOH
//
//  Created by Jerry Kwok on 14/5/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit

class HistoryDetialsViewController: UIViewController {

    var history:RegionHistory!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackClick(_ sender: Any) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: nil)
        self.dismiss(animated: false, completion: nil)
    }
    @IBAction func btnSettingClick(_ sender: Any) {
        let controller = UIAlertController(title: "", message: "AITOH", preferredStyle: .actionSheet)
        let names = ["Report History", "Archive History"]
        var count = 0
        for name in names {
            var action:UIAlertAction!
            if count == 0 {
                action = UIAlertAction(title: name, style: .destructive) { (action) in
                    let controller = UIAlertController(title: "", message: "Reported", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                      controller.addAction(okAction)
                    self.present(controller, animated: true, completion: nil)
               }
            }else{
                action = UIAlertAction(title: name, style: .default) { (action) in
                    let controller = UIAlertController(title: "", message: "History Saved", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                      controller.addAction(okAction)
                    self.present(controller, animated: true, completion: nil)
                }
            }
           controller.addAction(action)
            count = count + 1
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        controller.addAction(cancelAction)
        present(controller, animated: true, completion: nil)
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

extension HistoryDetialsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegionGroupHistoryCell") as! RegionGroupHistoryCell
        cell.initCommit(history: history)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 306
    }
}
