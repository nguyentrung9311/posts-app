//
//  AuthRepository.swift
//  Posts App
//
//  Created by TrungNV (Macbook) on 05/06/2023.
//

import Foundation

protocol AuthRepository {
    func login(
        username: String,
        password: String,
        success: ((LoginEntity) -> Void)?,
        failure: ((String?) -> Void)?
    )
}

class AuthRepositoryImpl: AuthRepository {
    var authApiService: AuthApiService
    
    init(authApiService: AuthApiService) {
        self.authApiService = authApiService
    }
    
    func login(username: String, password: String, success: ((LoginEntity) -> Void)?, failure: ((String?) -> Void)?) {
        authApiService.login(username: username, password: password, success: success, failure: failure)
    }
}


