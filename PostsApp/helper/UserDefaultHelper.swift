//
//  UserDefaultHelper.swift
//  PostsApp
//
//  Created by TrungNV (Macbook) on 09/06/2023.
//

import Foundation

class UserDefaultHelper {
    static let shared = UserDefaultHelper()
    private var standard = UserDefaults.standard
    
    private enum Keys: String {
        case tutorialCompleted
    }
    
    // Không cho khởi tạo instance của class này từ bên ngoài
    private init() {
        
    }
    
    var tutorialCompleted: Bool {
        get {
            return standard.bool(forKey: Keys.tutorialCompleted.rawValue)
        }
        
        set {
            standard.set(newValue, forKey: Keys.tutorialCompleted.rawValue)
            standard.synchronize()
        }
    }
    
    func clearAll(key: String) {
        standard.removeObject(forKey: key)
    }
}
