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
}

class AuthApiServiceImpl: AuthApiService {
    func login(username: String, password: String, success: ((LoginEntity) -> Void)?, failure: ((String?) -> Void)?) {
        let data = ["username": username, "password": password]
        AF.request("https://learn-api-3t7z.onrender.com/login",
                   method: .post,
                   parameters: data,
                   encoder: JSONParameterEncoder.default
        ).validate(statusCode: 200 ... 300).responseDecodable(of: LoginEntity.self, completionHandler: { response in
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
}
