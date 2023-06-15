//
//  HomePresenter.swift
//  PostsApp
//
//  Created by TrungNV (Macbook) on 09/06/2023.
//

import Foundation

protocol HomePresenter {
    func logout(accessToken: String)
    func getPost(page: Int, pageSize: Int)
    func loadMorePosts()
    func refreshPost()
}

class HomePresenterImpl : HomePresenter {
    var homeDelegate: HomeDelegate
    var authRepository: AuthRepository
    var postRepository: PostRepository
    
    init(homeDelegate: HomeDelegate, authRepository: AuthRepository, postRepository: PostRepository) {
        self.homeDelegate = homeDelegate
        self.authRepository = authRepository
        self.postRepository = postRepository
    }
    
    func logout(accessToken: String) {
        homeDelegate.onStartLogout()
        authRepository.logout(accessToken: accessToken) {
            self.homeDelegate.onLogoutSuccess()
        } failure: { error in
            self.homeDelegate.onLogoutFailure(error: error)
        }
    }
    
    func getPost(page: Int,
                 pageSize: Int
    ) {
        homeDelegate.onStartGetPosts()
        postRepository.getPost(page: page, pageSize: pageSize) { [self] postEntity in
            if let postDataArr = postEntity.data {
                homeDelegate.onGetPostSuccess(postDataArr: postDataArr)
            } else {
                homeDelegate.onGetPostError(error: "Post data is empty")
            }
        } failure: { error in
            self.homeDelegate.onGetPostError(error: error)
        }

    }
    
    func loadMorePosts() {
        
    }
    
    func refreshPost() {
        
    }
}
