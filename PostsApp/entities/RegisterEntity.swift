//
//  RegisterEntity.swift
//  PostsApp
//
//  Created by TrungNV (Macbook) on 07/06/2023.
//

import Foundation

struct RegisterEntity: Decodable {
    var userId: String?
    var accessToken: String?
    var refreshToken: String?
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}
