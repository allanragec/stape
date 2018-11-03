//
//  LoginViewModel.swift
//  Stape
//
//  Created by Allan Melo on 31/10/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

import Foundation

class LoginViewModel: NSObject {
    
    weak var viewController: LoginViewController?
    
    var sessionManager = SessionManager.shared
    
    init(_ viewController: LoginViewController) {
        self.viewController = viewController
        super.init()
        
        sessionManager.setSessionDelegate(delegate: self)
        setupViewController()
    }
    
    func startLoginLogoutAction() {
        viewController?.loginButton.isEnabled = false
        
        if Settings.isLogged {
            sessionManager.logout()
        }
        else {
            sessionManager.login()
        }
    }
    
    func closeAction() {
        viewController?.dismiss(animated: true, completion: nil)
    }
    
    private func setupViewController() {
        viewController?.closeButton.isHidden = !Settings.isLogged
        let buttonLoginTitle = Settings.isLogged ? "LOGOUT" : "LOGIN"
        viewController?.loginButton.setTitle(buttonLoginTitle, for: .normal)
    }
    
}

extension LoginViewModel: DeezerSessionDelegate {
    func deezerDidLogin() {
        viewController?.loginButton.isEnabled = true
        let deezerConnect = sessionManager.deezerConnect
        
        guard let accessToken = deezerConnect.accessToken,
            let userId = deezerConnect.userId,
            let expirationDate = deezerConnect.expirationDate else {
            return
        }
        
        Settings.saveSession(userId: userId, accessToken: accessToken, expirationDate: expirationDate.timeIntervalSince1970)
        viewController?.didLoginAction()
        closeAction()
    }
    
    func deezerDidNotLogin(_ cancelled: Bool) {
        viewController?.loginButton.isEnabled = true
        // TODO Show conection error 
    }
    
    func deezerDidLogout(){
        viewController?.loginButton.isEnabled = true
        
        Settings.clearSession()
        
        setupViewController()
    }
}

