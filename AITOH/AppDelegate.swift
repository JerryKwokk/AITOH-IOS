//
//  AppDelegate.swift
//  AITOH
//
//  Created by Jerry Kwok on 28/1/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit
import LocalAuthentication
import GoogleMaps
import ApiAI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        checkLogged()
        GMSServices.provideAPIKey("AIzaSyAimlTXyfphlB_CrEn2eD4dPVICemeoIYk")
        let configuration = AIDefaultConfiguration()
        configuration.clientAccessToken = "ff108b2d831140f6807c967b051a859d"
        print(configuration.clientAccessToken)
        let apiai = ApiAI.shared()
        apiai?.configuration = configuration
        
        // Override point for customization after application launch.
        return true
    }
    
    func checkLogged(){
        print("App")
        print(UserDefaults.standard.value(forKey: "username") ?? "test")
        print(UserDefaults.standard.value(forKey: "userId") ?? "test")
        if UserDefaults.standard.value(forKey: "username") != nil && UserDefaults.standard.value(forKey: "userId") != nil {
            print("true")
            let viewController = UIStoryboard(name: "Login", bundle:
                Bundle.main).instantiateViewController(withIdentifier: "TabViewController")
            let navViewController = UINavigationController(rootViewController: viewController)
            //let share = UIApplication.shared.delegate as? AppDelegate
            self.window?.rootViewController = navViewController
            self.window?.makeKeyAndVisible()
        }
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    


}

