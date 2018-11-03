//
//  Settings.swift
//  Stape
//
//  Created by Allan Melo on 30/10/18.
//  Copyright © 2018 Allan Melo. All rights reserved.
//

import Foundation

class Settings {
    static let TOKEN = "dzrSSA"
    static let USER_ID = "userId"
    static let EXPIRATION_DATE = "expirationDate"
    
    class var isLogged: Bool {
        return accessToken != nil && userId != nil && expirationDate != nil
    }
    
    class var accessToken: String? {
        get {
            return preferences.value(forKey: TOKEN) as? String
        }
        set {
            preferences.set(newValue, forKey: TOKEN)
        }
    }
    
    class var userId: String? {
        get {
            return preferences.value(forKey: USER_ID) as? String
        }
        set {
            preferences.set(newValue, forKey: USER_ID)
        }
    }
    
    class var expirationDate: Double? {
        get {
            return preferences.value(forKey: EXPIRATION_DATE) as? Double
        }
        set {
            preferences.set(newValue, forKey: EXPIRATION_DATE)
        }
    }
    
    class func saveSession(userId: String, accessToken: String, expirationDate: Double) {
        self.userId = userId
        self.accessToken = accessToken
        self.expirationDate = expirationDate
    }
    
    class func clearSession() {
        userId = nil
        accessToken = nil
        expirationDate = nil
    }
    
    class var preferences: UserDefaults {
        return UserDefaults.standard
    }
}
