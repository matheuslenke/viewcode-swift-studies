//
//  Alert.swift
//  LoginViewCode
//
//  Created by Matheus Lenke on 27/04/22.
//

import Foundation
import UIKit


class Alert: NSObject {
    var controller: UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    func getAlert(titulo: String, mensagem: String, completion: (() -> Void)? = nil ) {
        let alertController = UIAlertController(title: titulo, message: mensagem, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel) { _ in
            completion?()
        }
        alertController.addAction(action)
        self.controller.present(alertController, animated: true)
    }
}
