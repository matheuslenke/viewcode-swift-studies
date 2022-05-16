//
//  HomeVC.swift
//  MessengerApp
//
//  Created by Matheus Lenke on 06/05/22.
//

import UIKit
import Firebase

class HomeVC: UIViewController {
    
    var auth: Auth?
    var db: Firestore?
    var idUsuarioLogado: String?
    
    var screenContact: Bool?
    var emailUsuarioLogado: String?
    var alert: Alert?
    
    var screen: HomeScreen?
    
    var contato: ContatoController?
    var contactsList: [Contact] = []
    var conversationsList: [Conversation] = []
    var conversationsListener: ListenerRegistration?
    
    override func loadView() {
        self.screen = HomeScreen()
        self.view = self.screen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = CustomColor.appLight
        self.configHomeView()
        self.configCollectionView()
        self.configAlert()
        self.configIdentifierFirebase()
        self.configContato()
        self.addListenerRecuperarConversa()
    }
    
    private func configHomeView() {
        self.screen?.navView.delegate(delegate: self)
    }
    
    private func configCollectionView() {
        self.screen?.delegateCollectionView(delegate: self, dataSource: self)
    }
    
    private func configAlert() {
        self.alert = Alert(controller: self)
    }
    
    private func configIdentifierFirebase() {
        self.auth = Auth.auth()
        self.db = Firestore.firestore()
        
        // Recuperar id usuario logado
        if let currentUser = auth?.currentUser {
            self.idUsuarioLogado = currentUser.uid
            self.emailUsuarioLogado = currentUser.email
        }
    }
    
    private func configContato() {
        self.contato = ContatoController()
        self.contato?.delegate(delegate: self)
    }
    
    private func addListenerRecuperarConversa() {
        if let idUsuarioLogado = auth?.currentUser?.uid {
            self.conversationsListener = db?.collection(Constants.conversationsFirestoreCollection).document(idUsuarioLogado).collection(Constants.lastConversationsFirestoreCollection).addSnapshotListener({ querySnapshot, error in
                
                if error == nil {
                    self.conversationsList.removeAll()
                    
                    if let snapshot = querySnapshot {
                        for document in snapshot.documents {
                            let dados = document.data()
                            if let idDestinatario = dados["idDestinatario"] as? String, let nome = dados["nomeUsuario"] as? String{
                                let ultimaMensagem = dados["ultimaMensagem"] as? String
                                self.conversationsList.append(Conversation(nome: nome, ultimaMensagem: ultimaMensagem, idDestinatario: idDestinatario))
                            }
                        }
                        self.screen?.reloadCollectionView()
                    }
                }
            })
        }
    }
    
    func getContato() {
        self.contactsList.removeAll()
        self.db?.collection(Constants.usersFirestoreCollection).document(self.idUsuarioLogado ?? "").collection(Constants.contactsFirestoreCollection).getDocuments(completion: { snapshotResult, error in
            
            if error != nil {
                print("Error getContato")
                return
            }
            
            if let snapshot = snapshotResult {
                
                for document in snapshot.documents {
                    let dadosContato = document.data()
                    if let id = dadosContato["id"] as? String,
                       let nome = dadosContato["nome"] as? String {
                        self.contactsList.append(Contact(id: id, nome: nome))
                    }
                }
                self.screen?.reloadCollectionView()
            }
        })
    }
}

extension HomeVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.screenContact ?? false{
            return self.contactsList.count + 1
        }else{
            return self.conversationsList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if self.screenContact ?? false{
            if indexPath.row == self.contactsList.count{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageLastCollectionViewCell.identifier, for: indexPath)
                return cell
            }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageDetailCollectionViewCell.identifier, for: indexPath) as? MessageDetailCollectionViewCell
                cell?.setupContactView(contact: self.contactsList[indexPath.row])
                return cell ?? UICollectionViewCell()
            }
        }else{
            //Celula de Conversas
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageDetailCollectionViewCell.identifier, for: indexPath) as? MessageDetailCollectionViewCell
            cell?.setupConversationView(conversation: self.conversationsList[indexPath.row])
            return cell ?? UICollectionViewCell()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if self.screenContact ?? false{
            if indexPath.row == self.contactsList.count{
                self.alert?.addContact(completion: { value in
                    self.contato?.addContact(email: value, emailUsuarioLogado: self.emailUsuarioLogado ?? "", idUser: self.idUsuarioLogado ?? "")
                })
                
            }else{
                let VC:ChatViewController = ChatViewController()
                VC.contato = self.contactsList[indexPath.row]
                self.navigationController?.pushViewController(VC, animated: true)
            }
        }else{
            
            let VC:ChatViewController = ChatViewController()
            let dados = self.conversationsList[indexPath.row]
            let contato:Contact = Contact(id: dados.idDestinatario , nome: dados.nome )
            VC.contato = contato
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }
}



extension HomeVC:NavViewProtocol{
   
    func typeScreenMessage(type: TypeConversationOrContact) {
        switch type {
        case .contact:
            self.screenContact = true
            self.getContato()
            self.conversationsListener?.remove()
        case .conversation:
            self.screenContact = false
            self.addListenerRecuperarConversa()
            self.screen?.reloadCollectionView()
        }
        
    }

}


extension HomeVC:ContatoProtocol{
    func alertStateError(titulo: String, message: String) {
        self.alert?.getAlert(titulo: titulo, mensagem: message)
    }
    
    func successContato() {
        self.alert?.getAlert(titulo: "Ebaaaaaa", mensagem: "Usuario cadastrado com sucesso!!", completion: {
            self.getContato()
        })
    }
  
}
