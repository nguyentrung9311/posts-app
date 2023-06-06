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
            controller.validateFailure(message: "Username is require")
        } else {
            authRepository.login(username: username, password: password) { loginEntity in
                print("Success")
            } failure: { error in
                print(error)
            }

        }
    }
}
