//
//  HomeVC.swift
//  Messager
//
//  Created by Frédéric Helfer on 10/12/22.
//

import UIKit
import Firebase

class HomeVC: UIViewController {
    
    var auth: Auth?
    var db: Firestore?
    
    var contactScreen: Bool?
    var userIdLogged: String?
    var userEmailLogged: String?
    
    var alert: Alert?
    
    let homeView = HomeView()
    
    var contato: ContatoController?
    var contactList: [Contact] = []
    var conversasList: [Conversation] = []
    var conversasListener: ListenerRegistration?
    
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        configHomeView()
    }
    
    private func configHomeView() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = CustomColor.appLight
        
        homeView.navView.delegate(delegate: self)
        homeView.delegateCollectionView(delegate: self, dataSource: self)
        
        alert = Alert(controller: self)
        getContact()
        configIdentifierFirebase()
        configContato()
        addListenerRecuperarConversa()
    }
    
    private func configIdentifierFirebase() {
        self.auth = Auth.auth()
        self.db = Firestore.firestore()
        
        // recuperar id usuário logado
        if let currentUser = auth?.currentUser {
            self.userIdLogged = currentUser.uid
            self.userEmailLogged = currentUser.email
        }
    }
    
    private func configContato() {
        self.contato = ContatoController()
        self.contato?.delegate(delegate: self)
    }
    
    func addListenerRecuperarConversa() {
        
        if let userIdLogged = auth?.currentUser?.uid {
            self.conversasListener = db?.collection("conversas").document(userIdLogged).collection("ultimas_conversas").addSnapshotListener({ snapshotResult, error in
                
                if error == nil {
                    self.conversasList.removeAll()
                    
                    if let snapshotResult {
                        for document in snapshotResult.documents {
                            let data = document.data()
                            self.conversasList.append(Conversation(dictionary: data))
                        }
                        self.homeView.reloadCollectionView()
                    }
                }
            })
        }
    }
    
    func getContact() {
        contactList.removeAll()
        db?.collection("User").document(userIdLogged ?? "").collection("contatos").getDocuments(completion: { snapshotResult, error in
            if error != nil {
                print("error getContato")
                return
            }
            
            if let snapshotResult {
                for document in snapshotResult.documents {
                    let data = document.data()
                    self.contactList.append(Contact(dictionary: data))
                }
                self.homeView.reloadCollectionView()
            }
        })
    }
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if contactScreen ?? false {
            return self.contactList.count + 1
        } else {
            return self.conversasList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if contactScreen ?? false {
            
            //tela de contato
            if indexPath.row == self.contactList.count {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LastMessageCollectionViewCell.identifier, for: indexPath)
                return cell
            } else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailMessageCollectionViewCell.identifier, for: indexPath) as? DetailMessageCollectionViewCell
                cell?.setupView(contact: self.contactList[indexPath.row])
                return cell ?? UICollectionViewCell()
            }
        } else {
            
            //tela de conversas
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailMessageCollectionViewCell.identifier, for: indexPath) as? DetailMessageCollectionViewCell
            cell?.setupView(conversation: self.conversasList[indexPath.row])
            return cell ?? UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if self.contactScreen ?? false {
            if indexPath.row == self.contactList.count {
                self.alert?.addContact(completion: { value in
                    self.contato?.addContact(email: value, emailUsuarioLogado: self.userEmailLogged ?? "", userId: self.userIdLogged ?? "")
                })
            }
        } else {
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }
}

extension HomeVC: NavViewProtocol {
    func typeScreenMessage(type: TypeConversationOrContact) {
        switch type {
        case .contact:
            contactScreen = true
            self.getContact()
            self.conversasListener?.remove()
        case .conversation:
            contactScreen = false
            self.addListenerRecuperarConversa()
            self.homeView.reloadCollectionView()
        }
    }
}

extension HomeVC: ContatoProtocol {
    func alertStateError(title: String, message: String) {
        alert?.getAlert(title: title, message: message)
    }
    
    func successContato() {
        alert?.getAlert(title: "Ebaaa", message: "Usuário cadastrado com sucesso!", completion: {
            self.getContact()
        })
    }
    
    
}
