//
//  AppDelegate.swift
//  Stape
//
//  Created by Allan Melo on 30/10/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

import UIKit
//import D

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupSessionManager()
            
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = STTabBarController.shared
        window?.makeKeyAndVisible()
        
        return true
    }
    
    private func setupSessionManager() {
        if Settings.isLogged {
            SessionManager.shared.startDeezerConnect()
        }
    }

}

