//
//  KeychainHelper.swift
//  PostsApp
//
//  Created by TrungNV (Macbook) on 09/06/2023.
//

import Foundation
import KeychainSwift

class AuthHelper {
    static let shared = AuthHelper()
    private var keychain = KeychainSwift()
    
    enum Keys: String {
        case accessToken
        case refreshToken
    }
    
    private init() {
        
    }
    
    var accessToken: String {
        get {
            keychain.get(Keys.accessToken.rawValue) ?? ""
        }
        set {
            keychain.set(newValue, forKey: Keys.accessToken.rawValue)
        }
    }
    
    func isLogged() -> Bool {
        return !accessToken.isEmpty
    }
    
    func clear(key: String) {
        keychain.delete(key)
    }
}
