//
//  STTabBarController.swift
//  Stape
//
//  Created by Allan Melo on 30/10/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

import UIKit

class STTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    static let shared = STTabBarController()
    
    let playerMockViewController = UIViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        
        setupAppearance()
        
        if !Settings.isLogged {
            let loginViewController = LoginViewController()
            loginViewController.didLoginAction = { [weak self] in
                self?.createTabs()
            }
            
            tabBar.isHidden = true
            setViewControllers([loginViewController], animated: false)
        }
        else {
            createTabs()
        }
    }
    
    func showPlayer(music: Music, musics: [Music]) {
        let playerViewController = PlayerViewController(music: music, musics: musics)
        
        currentNavigation()?.present(playerViewController, animated: true, completion: nil)
    }
    
    func currentNavigation() -> UINavigationController? {
        return selectedViewController as? UINavigationController
    }
    
    private func setupAppearance() {
        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.barTintColor = UIColor(named: "tabBarBarTintColor")
        tabBarAppearance.isTranslucent = false
        tabBarAppearance.tintColor = UIColor(named: "tabBarIconColorSelected")
    }
    
    func createTabs() {
        tabBar.isHidden = false
        
        let homeNavigationController = createNavigationController(HomeViewController(), icon: "home")
        let playerViewController = createNavigationController(playerMockViewController, icon: "play")
        let searchNavigationController = createNavigationController(SearchViewController(), icon: "search")
        let profileNavigationController = createNavigationController(ProfileViewController(), icon: "profile")
        
        setViewControllers([homeNavigationController, playerViewController, profileNavigationController, searchNavigationController], animated: false)
    }
    
    private func createNavigationController(_ viewController: UIViewController, icon: String)
        -> UINavigationController {
            
        let icon = UIImage(named: icon)
        
        viewController.tabBarItem.selectedImage = icon
        viewController.tabBarItem.image = icon
        viewController.tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        return navigationController
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if let navigation = viewController as? UINavigationController,
            let topViewController = navigation.topViewController, topViewController == playerMockViewController  {
            
            let playerViewController = PlayerViewController()
            
            currentNavigation()?.present(playerViewController, animated: true, completion: nil)
            
            return false
        }
        
        
        return true
    }
}
