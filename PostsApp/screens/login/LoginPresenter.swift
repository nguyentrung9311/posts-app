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
    
    func validateForm(username: String, password: String) -> Bool {
        var isValid = true
        if username.isEmpty {
            controller.usernameInvalid(message: "Username is require")
            isValid = false
        } else if !(6...40).contains(username.count) {
            controller.usernameInvalid(message: "Username length must be >= 5 and <= 40")
            isValid = false
        }
        
        if password.isEmpty {
            controller.passwordInvalid(message: "Password is require")
            isValid = false
        } else if !(6...40).contains(password.count) {
            controller.passwordInvalid(message: "Password length must be >= 5 and <= 40")
            isValid = false
        }
        return isValid
    }
    
    func login(username: String, password: String) {
        if !validateForm(username: username, password: password) {
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
