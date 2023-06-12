//
//  HomeViewController.swift
//  PostsApp
//
//  Created by TrungNV (Macbook) on 09/06/2023.
//

import UIKit

protocol HomeDelegate {
    func onStartLogout()
    func onLogoutFailure(error: String?)
    func onLogoutSuccess()
}

class HomeViewController: UIViewController {
    var homePresenter: HomePresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        let authRepository = AuthRepositoryImpl(authApiService: AuthApiServiceImpl())
        homePresenter = HomePresenterImpl(homeDelegate: self, authRepository: authRepository)
    }
    
    @IBAction func onLogoutClicked(_ sender: Any) {
        homePresenter.logout(accessToken: AuthHelper.shared.accessToken)
    }
}

extension HomeViewController: HomeDelegate {
    func onStartLogout() {
        print("Start logout")
    }
    
    func onLogoutFailure(error: String?) {
        print("Logout error: \(error ?? "")")
    }
    
    func onLogoutSuccess() {
        print("Logout success")
    }
    
    
}
