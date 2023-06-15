//
//  HomePresenter.swift
//  PostsApp
//
//  Created by TrungNV (Macbook) on 09/06/2023.
//

import Foundation

protocol HomePresenter {
    func logout(accessToken: String)
}

class HomePresenterImpl : HomePresenter {
    var homeDelegate: HomeDelegate
    var authRepository: AuthRepository
    
    init(homeDelegate: HomeDelegate, authRepository: AuthRepository) {
        self.homeDelegate = homeDelegate
        self.authRepository = authRepository
    }
    
    func logout(accessToken: String) {
        homeDelegate.onStartLogout()
        authRepository.logout(accessToken: accessToken) {
            self.homeDelegate.onLogoutSuccess()
        } failure: { error in
            self.homeDelegate.onLogoutFailure(error: error)
        }
    }
}
