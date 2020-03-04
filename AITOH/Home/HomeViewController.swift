//
//  HomeViewController.swift
//  AITOH
//
//  Created by Jerry Kwok on 17/2/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  self.navigationController?.navigationBar.isHidden = true;
        let mainController: MainViewController = MainViewController(nibName: "MainViewController", bundle: nil)
        let locationController: LocationHomeViewController = LocationHomeViewController(nibName:"LocationHomeViewController", bundle: nil)
        let mapViewController: MapHomeViewController = MapHomeViewController(nibName: "MapHomeViewController", bundle: nil)
       
        
        self.addChild(locationController)
        self.scrollView.addSubview(locationController.view)
        mainController.didMove(toParent: self)
        
        self.addChild(mainController)
        self.scrollView.addSubview(mainController.view)
        mainController.didMove(toParent: self)
        
        self.addChild(mapViewController)
        self.scrollView.addSubview(mapViewController.view)
        mainController.didMove(toParent: self)
        
        
        
        
        var locationFrame: CGRect = mainController.view.frame
        locationFrame.origin.x = 0
        locationController.view.frame = locationFrame
        
        var mainFrame: CGRect = mainController.view.frame
        mainFrame.origin.x = self.view.frame.width
        mainController.view.frame = mainFrame
        
        var mapFrame: CGRect = mapViewController.view.frame
        mapFrame.origin.x = self.view.frame.width*2
        mapViewController.view.frame = mapFrame
        
        self.scrollView.contentSize =  CGSize(width: self.view.frame.width * 3, height: self.view.frame.height)
        scrollView.setContentOffset(CGPoint(x: mainFrame.width , y: 0), animated: true)
        
        
        // Do any additional setup after loading the view.
//        self.navigationController!.isNavigationBarHidden = true;
     //   self.tabBarController?.tabBar.isHidden = false
    }
    
    
        override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
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
