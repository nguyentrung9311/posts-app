//
//  PostApiService.swift
//  PostsApp
//
//  Created by TrungNV (Macbook) on 14/06/2023.
//

import Foundation
import Alamofire

protocol PostApiService {
    func getPost(page: Int,
                 pageSize: Int,
                 success: ((PostEntity) -> Void)?,
                 failure: ((String?) -> Void)?
    )
}

class PostApiServiceImpl: PostApiService {
    func getPost(page: Int, pageSize: Int, success: ((PostEntity) -> Void)?, failure: ((String?) -> Void)?) {
        let router = PostRouter.index(page: page, pageSize: pageSize)
        AF.request(router)
            .cURLDescription(calling: { curl in
                print("\(curl)")
            })
            .validate(statusCode: 200 ... 300)
            .responseDecodable(of: PostEntity.self, completionHandler: { response in
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
