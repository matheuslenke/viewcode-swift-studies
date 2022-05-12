//
//  ViewController.swift
//  LoginViewCode
//
//  Created by Matheus Lenke on 27/12/21.
//

import UIKit
import Firebase

class LoginVC: UIViewController {

    var auth: Auth?
    var loginScreen: LoginScreen?
    var alert: Alert?
    
    // Utilizado na criação/referenciação de uma view
    override func loadView() {
        self.loginScreen = LoginScreen()
        self.view = self.loginScreen // Faz a view desta VC ser igual a view LoginScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginScreen?.configTextFieldDelegate(delegate: self)
        self.loginScreen?.delegate(delegate: self)
        self.auth = Auth.auth()
        self.alert = Alert(controller: self)
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
        self.loginScreen?.validateTextFields()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
}

extension LoginVC: LoginScreenProtocol {
    func actionLoginButton() {
        
        guard let login = self.loginScreen else { return }

        self.auth?.signIn(withEmail: login.getEmail(), password: login.getPassword(), completion: { user, error in

            if error != nil {
                self.alert?.getAlert(titulo: "Error", mensagem: error?.localizedDescription ?? "Erro ao fazer login")
            } else {
                if user == nil {
                    self.alert?.getAlert(titulo: "Error", mensagem: "Erro inesperado, tente novamente mais tarde")
                } else {
                    let VC = HomeVC()
                    let navVC = UINavigationController(rootViewController: VC)
                    navVC.modalPresentationStyle = .fullScreen
                    self.present(navVC, animated: true, completion: nil)
                }
            }
        })
    }
    
    func actionRegisterButton() {
        let vc: RegisterVC = RegisterVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
