//
//  Alert.swift
//  Stape
//
//  Created by Allan Melo on 02/11/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

class Alert {
    class func showNetworkError(_ error: Error, completion: @escaping ()->() = {}) {
        let alert = UIAlertController(title: "Something wrong", message: "Could not load data, try again later", preferredStyle: .alert)
        alert.addAction(.init(title: "Ok", style: .default))
        
        STTabBarController.shared.present(alert, animated: true, completion: completion)
    }
}
