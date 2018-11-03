//
//  ProfileViewController.swift
//  Stape
//
//  Created by Allan Melo on 31/10/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBAction func openLogin(_ sender: Any) {
        navigationController?.present(LoginViewController(), animated: true, completion: nil)
    }
}
