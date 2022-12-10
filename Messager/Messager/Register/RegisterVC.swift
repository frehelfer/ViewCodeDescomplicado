//
//  RegisterVC.swift
//  LoginViewCode
//
//  Created by Frédéric Helfer on 06/12/22.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class RegisterVC: UIViewController {

    var registerScreen: RegisterScreen?
    
    var auth: Auth?
    var fireStore: Firestore?
    var alert: Alert?
    
    override func loadView() {
        registerScreen = RegisterScreen()
        view = registerScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerScreen?.delegate(delegate: self)
        registerScreen?.configTextFieldDelegate(delegate: self)
        
        self.auth = Auth.auth()
        self.fireStore = Firestore.firestore()
        alert = Alert(controller: self)
    }


}

extension RegisterVC: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        registerScreen?.validaTextField()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension RegisterVC: RegisterScreenProtocol {
    func actionRegisterButton() {
        guard
            let name = registerScreen?.nameTextField.text,
            let email = registerScreen?.emailTextField.text,
            let password = registerScreen?.passwordTextField.text else {
            return
        }
        
        auth?.createUser(withEmail: email, password: password, completion: { (result, error) in
            if error != nil {
                self.alert?.getAlert(title: "Atenção", message: "Erro ao cadastrar, verifique os dados e tente novamente.")
                print(error?.localizedDescription ?? "")
            } else {
                
                // salvar dados no firestore
                if let userId = result?.user.uid {
                    self.fireStore?.collection("user").document(userId).setData([
                        "name" : name,
                        "email" : email,
                        "id" : userId
                    ])
                }
                
                self.alert?.getAlert(title: "Sucesso!", message: "Usuário cadastrado com sucesso.", completion: {
                    let vc = UINavigationController(rootViewController: HomeVC())
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true)
                })
            }
        })
    }
}
