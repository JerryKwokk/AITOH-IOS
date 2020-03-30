//
//  MainViewController.swift
//  AITOH
//
//  Created by Jerry Kwok on 2/3/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class MainViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MAIN")
        // For use when the app is open & in the background
        locationManager.requestAlwaysAuthorization()
        
        // For use when the app is open
        //locationManager.requestWhenInUseAuthorization()
        
        // If location services is enabled get the users location
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest // You can change the locaiton accuary here.
            locationManager.startUpdatingLocation()
        }
        // Do any additional setup after loading the view.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{
            
            print(location.coordinate.latitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if(status == CLAuthorizationStatus.denied){
             print("test3")
            showLocationDisableAlert()
        }
    }
    
    func showLocationDisableAlert(){
        let alertController = UIAlertController(title: "Background Location Access Disable", message: "In order to give people nearby we need your location", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancel)
        let openSetting = UIAlertAction(title: "Open Setting", style: .default){(action) in
            if let url = URL(string: UIApplication.openSettingsURLString){
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alertController.addAction(openSetting)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func APIrequest(){
        
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
