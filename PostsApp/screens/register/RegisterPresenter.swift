//
//  RegisterPresenter.swift
//  PostsApp
//
//  Created by TrungNV (Macbook) on 07/06/2023.
//

import Foundation

protocol RegisterPresenter {
    func register(username: String, password: String, confirmPassword: String)
}

class RegisterPresenterIml: RegisterPresenter {
    var controller: RegisterDisplay
    var authRepository: AuthRepository
    
    init(controller: RegisterDisplay, authRepository: AuthRepository) {
        self.controller = controller
        self.authRepository = authRepository
    }
    
    func validateForm(username: String, password: String, confirmPassword: String) -> Bool {
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
        
        if confirmPassword.isEmpty {
            controller.confirmPasswordInvalid(message: "Confirm password is require")
            isValid = false
        } else if !(6...40).contains(confirmPassword.count) {
            controller.confirmPasswordInvalid(message: "Confirm password length must be >= 5 and <= 40")
            isValid = false
        } else if password != confirmPassword {
            controller.confirmPasswordInvalid(message: "Confirm password does not match")
            isValid = false
        }
        return isValid
    }
    
    func register(username: String, password: String, confirmPassword confrimPassword: String) {
        if !validateForm(username: username, password: password, confirmPassword: confrimPassword) {
            return
        }
        
        controller.onStartRegister()
        authRepository.register(username: username, password: password) { registerEntity in
            self.controller.onRegisterSuccess(registerEntity: registerEntity)
        } failure: { error in
            self.controller.onRegisterFailure(error: error)
        }
    }
}
