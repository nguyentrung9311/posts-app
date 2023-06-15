//
//  LoginViewController.swift
//  Posts App
//
//  Created by TrungNV (Macbook) on 05/06/2023.
//

import UIKit

protocol LoginDisplay {
    func usernameInvalid(message: String)
    func passwordInvalid(message: String)
    func onStartLogin()
    func onLoginFailure(error: String?)
    func onLoginSuccess(loginEntity: LoginEntity)
}

class LoginViewController: UIViewController {
    static let id = "LoginViewController"
    
    @IBOutlet weak var tfUsername: UIInputText!
    @IBOutlet weak var tfPassword: UIInputText!
    @IBOutlet weak var btLogin: UIButton!
    @IBOutlet weak var constraintLabelAlertUsername: NSLayoutConstraint!
    @IBOutlet weak var constraintLabelAlertPassword: NSLayoutConstraint!
    @IBOutlet weak var lbAlertUsername: UILabel!
    @IBOutlet weak var lbAlertPassword: UILabel!
    @IBOutlet weak var loadingView: UIView!
    
    var presenter: LoginPresenter!
    
    override func viewDidLoad() {
        let authApiService = AuthApiServiceImpl()
        let authRepository = AuthRepositoryImpl(authApiService: authApiService)
        presenter = LoginPresenterIml(controller: self, authRepository: authRepository)
        
        super.viewDidLoad()
        
        btLogin.tintColor = #colorLiteral(red: 0.01795377955, green: 0.6841192842, blue: 0.9446069598, alpha: 1)
        btLogin.layer.cornerRadius = 5
    }
    
    @IBAction func onForgotPasswordClicked(_ sender: Any) {
        
    }
    
    @IBAction func onLoginClicked(_ sender: Any) {
        presenter.login(username: tfUsername.text ?? "", password: tfPassword.text ?? "")
        btLogin.layer.opacity = 1
    }
    
    @IBAction func onButtonLoginTouchDown(_ sender: Any) {
        btLogin.layer.opacity = 0.8
    }
    
    @IBAction func onRegisterClicked(_ sender: Any) {
        let registerVC = RegisterViewController()
        navigationController?.pushViewController(registerVC, animated: true)
    }
}

extension LoginViewController: LoginDisplay {
    func onLoginFailure(error: String?) {
        loadingView.isHidden = true
        print("Login failure: \(error ?? "")")
        AuthHelper.shared.clear(key: AuthHelper.Keys.accessToken.rawValue)
    }
    
    func onLoginSuccess(loginEntity: LoginEntity) {
        loadingView.isHidden = true
        print("Login success")
        if let accessToken = loginEntity.accessToken, !accessToken.isEmpty {
            AuthHelper.shared.accessToken = accessToken
            navigationController?.pushViewController(MainViewController(), animated: true)
        } else {
            AuthHelper.shared.accessToken = ""
        }
    }
    
    func onStartLogin() {
        self.constraintLabelAlertUsername.constant = 0
        self.constraintLabelAlertPassword.constant = 0
        loadingView.isHidden = false
    }
    
    func passwordInvalid(message: String) {
        lbAlertPassword.text = message
        self.constraintLabelAlertPassword.constant = 15
    }
    
    func usernameInvalid(message: String) {
        lbAlertUsername.text = message
        self.constraintLabelAlertUsername.constant = 15
    }
}
