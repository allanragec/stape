//
//  ProfileViewController.swift
//  Stape
//
//  Created by Allan Melo on 31/10/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var portraitImageView: UIImageView!
    
    lazy var viewModel: ProfileViewModel = {
        return ProfileViewModel(self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDidLoad()
        
        navigationItem.title = "Profile"
    }
    
    @IBAction func openLogin(_ sender: Any) {
        let loginViewController = LoginViewController()
        
        loginViewController.didLoginAction = {
            STTabBarController.shared.createTabs()
        }
        
        navigationController?.present(loginViewController, animated: true, completion: nil)
    }
}
