//
//  RegisterViewController.swift
//  Posts App
//
//  Created by TrungNV (Macbook) on 04/06/2023.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var tfUsername: UIInputText!
    @IBOutlet weak var tfPassword: UIInputText!
    @IBOutlet weak var tfConfirmPassword: UIInputText!
    @IBOutlet weak var btRegister: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btRegister.tintColor = #colorLiteral(red: 0.01795377955, green: 0.6841192842, blue: 0.9446069598, alpha: 1)
    }
    
    @IBAction func onLoginClicked(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func onBackClicked(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func onRegisterClicked(_ sender: Any) {
        
    }
}
