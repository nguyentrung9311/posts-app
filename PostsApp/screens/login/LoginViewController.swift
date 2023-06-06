//
//  LoginViewController.swift
//  Posts App
//
//  Created by TrungNV (Macbook) on 05/06/2023.
//

import UIKit

protocol LoginDisplay {
    func validateFailure(message: String)
}

class LoginViewController: UIViewController {
    @IBOutlet weak var tfUsername: UIInputText!
    @IBOutlet weak var tfPassword: UIInputText!
    @IBOutlet weak var btLogin: UIButton!
    
    var presenter: LoginPresenter!
    
    override func viewDidLoad() {
        let authApiService = AuthApiServiceImpl()
        let authRepository = AuthRepositoryImpl(authApiService: authApiService)
        presenter = LoginPresenterIml(controller: self, authRepository: authRepository)
        
        super.viewDidLoad()
        
        btLogin.tintColor = #colorLiteral(red: 0.01795377955, green: 0.6841192842, blue: 0.9446069598, alpha: 1)
    }

    @IBAction func onForgotPasswordClicked(_ sender: Any) {
        
    }
    
    @IBAction func onLoginClicked(_ sender: Any) {
        presenter.login(username: "ABCABC", password: "123456")
    }
    
    @IBAction func onRegisterClicked(_ sender: Any) {
        let registerVC = RegisterViewController()
        registerVC.modalPresentationStyle = .fullScreen
        present(registerVC, animated: true)
    }
}

extension LoginViewController: LoginDisplay {
    func validateFailure(message: String) {
        print(message)
    }
    
    
}
