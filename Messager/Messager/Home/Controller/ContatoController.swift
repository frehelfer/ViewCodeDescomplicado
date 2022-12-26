//
//  ContatoController.swift
//  Messager
//
//  Created by Frédéric Helfer on 12/12/22.
//

import Foundation
import UIKit
import FirebaseFirestore

protocol ContatoProtocol: AnyObject {
    func alertStateError(title: String, message: String)
    func successContato()
}

class ContatoController {
    
    weak private var delegate: ContatoProtocol?
    
    public func delegate(delegate: ContatoProtocol?) {
        self.delegate = delegate
    }
    
    func addContact(email: String, emailUsuarioLogado: String, userId: String) {
        if email == emailUsuarioLogado {
            self.delegate?.alertStateError(title: "Você adiconou seu próprio email", message: "Adicione um email diferente.")
            return
        }
        
        //verificar se existe usuário no firebase
        let firestore = Firestore.firestore()
        firestore.collection("user").whereField("email", isEqualTo: email).getDocuments { snapShotResult, error in
            
            // conta total do retorno
            if let totalItems = snapShotResult?.count {
                if totalItems == 0 {
                    self.delegate?.alertStateError(title: "Usuário não cadastrado", message: "Verifique o email e tente novamente.")
                    return
                }
            }
            
            // salvar contato
            if let snapShot = snapShotResult {
                for document in snapShot.documents {
                    let dados = document.data()
                    self.salvarContato(dadosContato: dados, userId: userId)
                }
            }
        }
    }
    
    func salvarContato(dadosContato: Dictionary<String,Any>, userId: String) {
        let contact = Contact(dictionary: dadosContato)
        let firestore = Firestore.firestore()
        
        firestore.collection("user").document(userId).collection("contatos").document(contact.id ?? "").setData(dadosContato) { error in
            if error == nil {
                self.delegate?.successContato()
            }
        }
    }
}
