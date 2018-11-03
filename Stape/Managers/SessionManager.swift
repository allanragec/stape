//
//  DeezerSessionManager.swift
//  Stape
//
//  Created by Allan Melo on 31/10/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

import Foundation

class SessionManager {
    
    private static let DEEZER_APP_ID = "308804"
    
    static let shared = SessionManager()
    
    let deezerConnect: DeezerConnect = DeezerConnect(appId: DEEZER_APP_ID, andDelegate: nil)
    
    private init() {
        startDeezerConnect()
    }
    
    func isSessionValid() -> Bool {
        if Settings.isLogged {
            if !deezerConnect.isSessionValid() {
                deezerConnect.accessToken = nil
                Settings.clearSession()
            }
        }
        
        return deezerConnect.isSessionValid()
    }
    
    func startDeezerConnect() {
        DZRRequestManager.default().dzrConnect = deezerConnect
        
        if Settings.isLogged {
            deezerConnect.accessToken = Settings.accessToken
            deezerConnect.userId = Settings.userId
            deezerConnect.expirationDate = Date(timeIntervalSince1970: Settings.expirationDate ?? 0)
        }
    }
    
    func setSessionDelegate(delegate: DeezerSessionDelegate) {
        deezerConnect.sessionDelegate = delegate
    }
    
    func login() {
        deezerConnect.authorize([DeezerConnectPermissionBasicAccess])
    }
    
    func logout() {
        deezerConnect.logout()
    }
}
