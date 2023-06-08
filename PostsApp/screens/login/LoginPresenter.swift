//
//  LoginPresenter.swift
//  Posts App
//
//  Created by TrungNV (Macbook) on 05/06/2023.
//

import Foundation

protocol LoginPresenter {
    func login(username: String, password: String)
}

class LoginPresenterIml: LoginPresenter {
    var controller: LoginDisplay
    var authRepository: AuthRepository
    
    init(controller: LoginDisplay, authRepository: AuthRepository) {
        self.controller = controller
        self.authRepository = authRepository
    }
    
//    func validateForm() -> Bool {
//        return false
//    }
    
    func login(username: String, password: String) {
        if username.isEmpty {
            controller.usernameInvalid(message: "Username is require")
            return
        } else if username.count < 6 {
            controller.usernameInvalid(message: "Username length must be > 5")
            return
        }
        
        if password.isEmpty {
            controller.passwordInvalid(message: "Password is require")
            return
        } else if password.count < 6 {
            controller.passwordInvalid(message: "Password length must be > 5")
            return
        }
        
        controller.onStartLogin()
        authRepository.login(username: username, password: password) { loginEntity in
            self.controller.onLoginSuccess()
        } failure: { error in
            self.controller.onLoginFailure(error: error)
        }
    }
}
