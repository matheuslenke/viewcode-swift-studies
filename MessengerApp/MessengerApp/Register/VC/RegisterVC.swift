//
//  RegisterVC.swift
//  LoginViewCode
//
//  Created by Matheus Lenke on 21/01/22.
//

import UIKit
import Firebase

class RegisterVC: UIViewController {
    
    var registerScreen: RegisterScreen?
    
    var auth: Auth?
    var firestore: Firestore?
    var alert: Alert?
    
    override func loadView() {
        self.registerScreen = RegisterScreen()
        self.view = self.registerScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerScreen?.configTextFieldDelegate(delegate: self)
        self.registerScreen?.delegate(self)
        self.auth = Auth.auth()
        self.firestore = Firestore.firestore()
        self.alert = Alert(controller: self)
    }
}

extension RegisterVC: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.registerScreen?.validateTextFields()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension RegisterVC: RegisterScreenProtocol {
    func actionBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func actionRegisterButton() {
        
        guard let register = self.registerScreen else { return }
        
        self.auth?.createUser(withEmail: register.getEmail(), password: register.getPassword(), completion: { result, error in
            if error != nil {
                self.alert?.getAlert(titulo: "Error", mensagem: error?.localizedDescription ?? "Erro ao cadastrar")
            } else {
                // Salvar dados no Firebase
                if let idUsuario = result?.user.uid {
                    self.firestore?.collection("usuarios").document(idUsuario).setData([
                        "nome": self.registerScreen?.getName() ?? "",
                        "email": self.registerScreen?.getEmail() ?? "",
                        "id": idUsuario
                    ])
                }
                
                let VC = HomeVC()
                let navVC = UINavigationController(rootViewController: VC)
                navVC.modalPresentationStyle = .fullScreen
                self.present(navVC, animated: true, completion: nil)
            }
        })
        
    }
    
    
}
