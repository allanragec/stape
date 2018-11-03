//
//  LoginViewController.swift
//  Stape
//
//  Created by Allan Melo on 30/10/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    var viewModel: LoginViewModel?
    var didLoginAction = {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = LoginViewModel(self)
    }
    
    @IBAction func closeAction(_ sender: Any) {
        viewModel?.closeAction()
    }
    
    @IBAction func loginAction(_ sender: Any) {
        viewModel?.startLoginLogoutAction()
    }
}
