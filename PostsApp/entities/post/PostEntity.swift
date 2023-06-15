//
//  PostEntity.swift
//  PostsApp
//
//  Created by TrungNV (Macbook) on 14/06/2023.
//


/**
 {
     "data": [
         {
             "title": "Test",
             "content": "Hello",
             "address": "No 8, Ngoc Ha, Kim Tan",
             "author": {
                 "username": "admin",
                 "created_at": "2023-04-29T06:31:02.305Z",
                 "updated_at": "2023-04-29T06:31:02.305Z",
                 "profile": {
                     "bio": "3333",
                     "created_at": "2023-06-03T15:43:37.843Z",
                     "updated_at": "2023-06-03T15:43:37.843Z",
                     "gender": "male",
                     "avatar": "https://techmaster.s3.ap-northeast-1.amazonaws.com/1685807005655_avatar_avatar_1685807005.349679.jpg"
                 },
                 "is_admin": true,
                 "id": "644cb9a6d4ad82105fb2dbc1"
             },
             "created_at": "2023-04-29T12:13:23.910Z",
             "updated_at": "2023-04-29T12:13:23.910Z",
             "id": "644d09e305a6223370b043ad"
         }
     ],
     "page": 1,
     "pageSize": 20
 }
 */

import Foundation

struct PostEntity: Decodable {
    var data: [PostData]?
    var page: Int?
    var pageSize: Int?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case page = "page"
        case pageSize = "pageSize"
    }
}

/**
 "content": "Hello",
             "address": "No 8, Ngoc Ha, Kim Tan",
 */
struct PostData: Decodable {
    var id: String?
    var title: String?
    var author: PostAuthor?
    var createdAt: String?
    var updatedAt: String?
    var content: String?
    var address: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case author = "author"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case content = "content"
        case address = "address"
    }
}

/**
 "author": {
                 "username": "admin",
                 "created_at": "2023-04-29T06:31:02.305Z",
                 "updated_at": "2023-04-29T06:31:02.305Z",
                 "profile": {
                     "bio": "3333",
                     "created_at": "2023-06-03T15:43:37.843Z",
                     "updated_at": "2023-06-03T15:43:37.843Z",
                     "gender": "male",
                     "avatar": "https://techmaster.s3.ap-northeast-1.amazonaws.com/1685807005655_avatar_avatar_1685807005.349679.jpg"
                 },
                 "is_admin": true,
                 "id": "644cb9a6d4ad82105fb2dbc1"
             }
 */
struct PostAuthor: Decodable {
    var username: String?
    var createdAt: String?
    var updatedAt: String?
    var profile: PostProfile?
    var isAdmin: Bool?
    var id: String?
    
    enum CodingKeys: String, CodingKey {
        case username = "username"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case profile = "profile"
        case isAdmin = "is_admin"
        case id = "id"
    }
}

/**
 "profile": {
                     "bio": "3333",
                     "created_at": "2023-06-03T15:43:37.843Z",
                     "updated_at": "2023-06-03T15:43:37.843Z",
                     "gender": "male",
                     "avatar": "https://techmaster.s3.ap-northeast-1.amazonaws.com/1685807005655_avatar_avatar_1685807005.349679.jpg"
                 }
 */
struct PostProfile: Decodable {
    var bio: String?
    var createdAt: String?
    var updatedAt: String?
    var gender: String?
    var avatar: String?
    
    enum CodinKeys: String, CodingKey {
        case bio = "bio"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case gender = "gender"
        case avatar = "avatar"
    }
}

