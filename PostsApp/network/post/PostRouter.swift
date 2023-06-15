//
//  PostRouter.swift
//  PostsApp
//
//  Created by TrungNV (Macbook) on 14/06/2023.
//

import Foundation
import Alamofire

enum PostRouter: URLRequestConvertible {
    case index(page: Int, pageSize: Int)
    
    var baseURL: URL {
        return URL(string: "https://learn-api-3t7z.onrender.com")!
    }
    
    var method: HTTPMethod {
        switch self {
        case .index: return .get
        }
    }
    
    var path: String {
        switch self {
        case .index: return "posts"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .index(let page, let pageSize):
            return [
                "page": page,
                "pageSize": pageSize
            ]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method
        
        if AuthHelper.shared.isLogged() {
            request.setValue("Bearer \(AuthHelper.shared.accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        switch self .method {
        case .get:
            request = try URLEncoding.default.encode(request, with: parameters)
        default:
            request = try JSONEncoding.default.encode(request, with: parameters)
        }
        request.timeoutInterval = 30
        
        return request
    }
}
