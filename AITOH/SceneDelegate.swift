//
//  SceneDelegate.swift
//  AITOH
//
//  Created by Jerry Kwok on 28/1/2020.
//  Copyright © 2020 AITOH. All rights reserved.
//

import UIKit


class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options 
        connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }


               self.window = UIWindow(windowScene: windowScene)
               //self.window =  UIWindow(frame: UIScreen.main.bounds)
               if UserDefaults.standard.value(forKey: "username") != nil && UserDefaults.standard.value(forKey: "userId") != nil {
                if(UserDefaults.standard.value(forKey: "passcode") != nil){
                   let storyboard = UIStoryboard(name: "Passcode", bundle: nil)
                   guard let rootVC = storyboard.instantiateViewController(identifier: "PasscodeViewController") as? PasscodeViewController else {
                       print("ViewController not found")
                       return
                   }
                    let rootNC = UINavigationController(rootViewController: rootVC)
                                  self.window?.rootViewController = rootNC
                                  self.window?.makeKeyAndVisible()
                }else{
                    
                   let storyboard = UIStoryboard(name: "Login", bundle: nil)
                    guard let rootVC = storyboard.instantiateViewController(identifier: "LoginViewController") as? LoginViewController else {
                        print("ViewController not found")
                        return
                    }
                    let rootNC = UINavigationController(rootViewController: rootVC)
                                  self.window?.rootViewController = rootNC
                                  self.window?.makeKeyAndVisible()
                }
               }else{
                let storyboard = UIStoryboard(name: "Login", bundle: nil)
                guard let rootVC = storyboard.instantiateViewController(identifier: "LoginViewController") as? LoginViewController else {
                    print("ViewController not found")
                    return
                }
                let rootNC = UINavigationController(rootViewController: rootVC)
                              self.window?.rootViewController = rootNC
                              self.window?.makeKeyAndVisible()
                
               }
              
        
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
       // window = UIWindow(frame: windowScene.coordinateSpace.bounds)
       // window?.windowScene = windowScene

        
        // If this scene's self.window is nil then set a new UIWindow object to it.
      /*  self.window = self.window ?? UIWindow()
            
        // Set this scene's window's background color.
        self.window!.backgroundColor = UIColor.white
        
        if UserDefaults.standard.value(forKey: "username") == nil || UserDefaults.standard.value(forKey: "userId") == nil {
            self.window!.rootViewController = LoginViewController()
        }else{
            print(UserDefaults.standard.string(forKey: "passcode"))
            if UserDefaults.standard.value(forKey: "passcode") != nil {
                self.window!.rootViewController = PasscodeViewController()
            }else{
                self.window!.rootViewController = HomeViewController()
            }
        }
        // Create a ViewController object and set it as the scene's window's root view controller.
        
        // Make this scene's window be visible.
        self.window!.makeKeyAndVisible()
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }*/
    }
    
    /*func loadBaseController() {
       let storyboard : UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
       self.window = self.window ?? UIWindow()
       
       if UserDefaults.standard.value(forKey: "username") == nil || UserDefaults.standard.value(forKey: "userId") == nil {
        if(UserDefaults.standard.value(forKey: "passcode") != nil){
            print("Scene True")
            let passcodeStorybaord: UIStoryboard = UIStoryboard(name: "Passcode", bundle: nil)
            let passcodeVC: PasscodeViewController = passcodeStorybaord.instantiateViewController(withIdentifier: "PasscodeViewController") as! PasscodeViewController
            self.window?.rootViewController = passcodeVC
        }else{
           let loginVC: LoginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
           self.window?.rootViewController = loginVC
        }
       } else {
           let homeVC: TabViewController = storyboard.instantiateViewController(withIdentifier: "TabViewController") as! TabViewController
           let navigationHomeVC = UINavigationController(rootViewController: homeVC)
           self.window?.rootViewController = navigationHomeVC
       }
        self.window?.makeKeyAndVisible()
        
    }*/

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
          if(UserDefaults.standard.value(forKey: "passcode") != nil){
                         let storyboard = UIStoryboard(name: "Passcode", bundle: nil)
                         guard let rootVC = storyboard.instantiateViewController(identifier: "PasscodeViewController") as? PasscodeViewController else {
                             print("ViewController not found")
                             return
                         }
                          let rootNC = UINavigationController(rootViewController: rootVC)
                                        self.window?.rootViewController = rootNC
                                        self.window?.makeKeyAndVisible()
        }
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    

}

