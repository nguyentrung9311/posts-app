//
//  AuthApiService.swift
//  Posts App
//
//  Created by TrungNV (Macbook) on 05/06/2023.
//

import Foundation
import Alamofire

protocol AuthApiService {
    func login(
        username: String,
        password: String,
        success: ((LoginEntity) -> Void)?,
        failure: ((String?) -> Void)?
    )
    
    func register(
        username: String,
        password: String,
        success: ((RegisterEntity) -> Void)?,
        failure: ((String?) -> Void)?
    )
    
    func logout(token: String, success: (() -> Void)?, failure: ((String?) -> Void)?)
}

class AuthApiServiceImpl: AuthApiService {
    func login(username: String, password: String, success: ((LoginEntity) -> Void)?, failure: ((String?) -> Void)?) {
        let data = ["username": username, "password": password]
        AF.request(AuthRouter.login(body: data)).validate(statusCode: 200 ... 300).responseDecodable(of: LoginEntity.self, completionHandler: { response in
            switch response.result {
            case .success(let entity):
                success?(entity)
                break
            case .failure(let error):
                failure?(error.localizedDescription)
                break
            }
        })
    }
    
    func register(username: String, password: String, success: ((RegisterEntity) -> Void)?, failure: ((String?) -> Void)?) {
        let data = ["username": username, "password": password]
        AF.request(AuthRouter.register(body: data)).validate(statusCode: 200 ... 300).responseDecodable(of: RegisterEntity.self) { response in
            switch response.result {
            case .success(let entity):
                success?(entity)
                break
            case .failure(let error):
                if let data = response.data {
                    print("Register error: \(String(data: data, encoding: .utf8) ?? "")")
                }
                failure?(error.errorDescription)
                break
            }
        }
    }
    
    func logout(token: String, success: (() -> Void)?, failure: ((String?) -> Void)?) {
        AF.request(AuthRouter.logout).validate(statusCode: 200 ... 300).response { response in
            switch response.result {
            case .success(_):
                success?()
                break
            case .failure(let error):
                if let data = response.data {
                    print("Logout error: \(String(data: data, encoding: .utf8) ?? "")")
                }
                failure?(error.errorDescription)
                break
            }
        }
    }
}
