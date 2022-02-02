//
//  ViewController.swift
//  LoginViewCode
//
//  Created by Matheus Lenke on 27/12/21.
//

import UIKit

class LoginVC: UIViewController {

    var loginScreen: LoginScreen?
    
    // Utilizado na criação/referenciação de uma view
    override func loadView() {
        self.loginScreen = LoginScreen()
        self.loginScreen?.delegate(delegate: self)
        self.view = self.loginScreen // Faz a view desta VC ser igual a view LoginScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginScreen?.configTextFieldDelegate(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

}

extension LoginVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("TextFieldDidEndEditing")
        self.loginScreen?.validateTextFields()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("TextFieldDidBeginEditing")
    }
}

extension LoginVC: LoginScreenProtocol {
    func actionLoginButton() {
        print("Logando")
    }
    
    func actionRegisterButton() {
        print("Registrando")
        let vc: RegisterVC = RegisterVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
