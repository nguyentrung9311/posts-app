//
//  PostRepository.swift
//  PostsApp
//
//  Created by TrungNV (Macbook) on 14/06/2023.
//

import Foundation

protocol PostRepository {
    func getPost(page: Int,
                 pageSize: Int,
                 success: ((PostEntity) -> Void)?,
                 failure: ((String?) -> Void)?
    )
}

class PostRepositoryImpl: PostRepository {
    var postApiService: PostApiService
    
    init(postApiService: PostApiService) {
        self.postApiService = postApiService
    }
    
    func getPost(page: Int, pageSize: Int, success: ((PostEntity) -> Void)?, failure: ((String?) -> Void)?) {
        postApiService.getPost(page: page, pageSize: pageSize, success: success, failure: failure)
    }
}
