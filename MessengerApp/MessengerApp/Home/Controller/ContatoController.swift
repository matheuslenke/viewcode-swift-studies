//
//  ContatoController.swift
//  MessengerApp
//
//  Created by Matheus Lenke on 09/05/22.
//

import UIKit
import FirebaseFirestore

protocol ContatoProtocol: AnyObject {
    func alertStateError(titulo: String, message: String)
    func successContato()
}

class ContatoController {
    
    weak var delegate: ContatoProtocol?
    
    public func delegate(delegate: ContatoProtocol?) {
        self.delegate = delegate
    }
    
    func addContact(email: String, emailUsuarioLogado: String, idUser: String) {
        
        if email == emailUsuarioLogado {
            self.delegate?.alertStateError(titulo: "Error", message: "Você adicionou seu próprio email, adicione um email diferente")
            return
        }
        
        // Verificar se o usuário existe no firebase
        let firestore = Firestore.firestore()
        firestore.collection(Constants.usersFirestoreCollection).whereField("email", isEqualTo: email)
            .getDocuments { snapshotResultado, error in
                
                // Conta total de retorno
                if let totalItens = snapshotResultado?.count {
                    if totalItens == 0 {
                        self.delegate?.alertStateError(titulo: "Usuário não cadastrado", message: "Verifique o e-mail e tente novamente")
                        return
                    }
                }
                
                // Salvar contato
                if let snapshot = snapshotResultado {
                    for document in snapshot.documents {
                        let dados = document.data()
                        self.salvarContato(dadosContato: dados, idUsuario: idUser)
                    }
                }
            }
    }
    
    func salvarContato(dadosContato: Dictionary<String, Any>, idUsuario: String) {
        if let name = dadosContato["nome"] as? String,
           let id = dadosContato["id"] as? String {
            let contact = Contact(id: id, nome: name)
            let firestore = Firestore.firestore()
            
            firestore.collection(Constants.usersFirestoreCollection).document(idUsuario).collection(Constants.contactsFirestoreCollection).document(contact.id ).setData(dadosContato) {
                error in
                if error == nil {
                    self.delegate?.successContato()
                }
            }
        }
    }
}
