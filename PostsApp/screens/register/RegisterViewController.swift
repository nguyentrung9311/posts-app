//
//  RegisterViewController.swift
//  Posts App
//
//  Created by TrungNV (Macbook) on 04/06/2023.
//

import UIKit

protocol RegisterDisplay {
    func usernameInvalid(message: String)
    func passwordInvalid(message: String)
    func confirmPasswordInvalid(message: String)
    func onStartRegister()
    func onRegisterFailure(error: String?)
    func onRegisterSuccess(registerEntity: RegisterEntity)
}

class RegisterViewController: UIViewController {
    @IBOutlet weak var tfUsername: UIInputText!
    @IBOutlet weak var tfPassword: UIInputText!
    @IBOutlet weak var tfConfirmPassword: UIInputText!
    @IBOutlet weak var btRegister: UIButton!
    @IBOutlet weak var lbAlertUsername: UILabel!
    @IBOutlet weak var lbAlertPassword: UILabel!
    @IBOutlet weak var lbAlertConfirmPassword: UILabel!
    @IBOutlet weak var constraintAlertUsername: NSLayoutConstraint!
    @IBOutlet weak var constraintAlertPassword: NSLayoutConstraint!
    @IBOutlet weak var constraintAlertConfirmPassword: NSLayoutConstraint!
    @IBOutlet weak var loadingView: UIView!
    
    var registerPresenter: RegisterPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let authApiService = AuthApiServiceImpl()
        let authRepository = AuthRepositoryImpl(authApiService: authApiService)
        
        registerPresenter = RegisterPresenterIml(controller: self, authRepository: authRepository)

        btRegister.tintColor = #colorLiteral(red: 0.01795377955, green: 0.6841192842, blue: 0.9446069598, alpha: 1)
        btRegister.layer.cornerRadius = 5
    }
    
    @IBAction func onUsernameChanged(_ sender: Any) {
        hideAlerts()
    }
    
    @IBAction func onPasswordChanged(_ sender: Any) {
        hideAlerts()
    }
    
    @IBAction func onConfirmPasswordChanged(_ sender: Any) {
        hideAlerts()
    }
    
    @IBAction func onLoginClicked(_ sender: Any) {
        btRegister.layer.opacity = 1
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onButtonRegisterTouchDown(_ sender: Any) {
        btRegister.layer.opacity = 0.8
    }
    
    @IBAction func onBackClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onRegisterClicked(_ sender: Any) {
        registerPresenter.register(username: tfUsername.text ?? "", password: tfPassword.text ?? "", confirmPassword: tfConfirmPassword.text ?? "")
    }
    
    private func hideAlerts() {
        constraintAlertUsername.constant = 0
        constraintAlertPassword.constant = 0
        constraintAlertConfirmPassword.constant = 0
    }
}

extension RegisterViewController: RegisterDisplay {
    func confirmPasswordInvalid(message: String) {
        lbAlertConfirmPassword.text = message
        constraintAlertConfirmPassword.constant = 15
    }
    
    func usernameInvalid(message: String) {
        lbAlertUsername.text = message
        constraintAlertUsername.constant = 15
    }
    
    func passwordInvalid(message: String) {
        lbAlertPassword.text = message
        constraintAlertPassword.constant = 15
    }
    
    func onStartRegister() {
        loadingView.isHidden = false
    }
    
    func onRegisterFailure(error: String?) {
        loadingView.isHidden = true
        print("Register failure: \(error ?? "")")
        AuthHelper.shared.clear(key: AuthHelper.Keys.accessToken.rawValue)
    }
    
    func onRegisterSuccess(registerEntity: RegisterEntity) {
        loadingView.isHidden = true
        print("Register success")
        if let accessToken = registerEntity.accessToken, !accessToken.isEmpty {
            AuthHelper.shared.accessToken = accessToken
            navigationController?.pushViewController(MainTabBarViewController(), animated: true)
//            let window = (UIApplication.shared.delegate as? AppDelegate)?.window
//            window?.rootViewController = HomeViewController()
//            window?.makeKeyAndVisible()
        } else {
            AuthHelper.shared.accessToken = ""
        }
    }
    
    
}
