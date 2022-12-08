//
//  RegisterVC.swift
//  LoginViewCode
//
//  Created by Frédéric Helfer on 06/12/22.
//

import UIKit
import FirebaseAuth

class RegisterVC: UIViewController {

    var registerScreen: RegisterScreen?
    
    var auth: Auth?
    var alert: Alert?
    
    override func loadView() {
        registerScreen = RegisterScreen()
        view = registerScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerScreen?.delegate(delegate: self)
        registerScreen?.configTextFieldDelegate(delegate: self)
        
        auth = Auth.auth()
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
            let email = registerScreen?.emailTextField.text,
            let password = registerScreen?.passwordTextField.text else {
            return
        }
        
        auth?.createUser(withEmail: email, password: password, completion: { (result, error) in
            if error != nil {
                self.alert?.getAlert(title: "Atenção", message: "Erro ao cadastrar, verifique os dados e tente novamente.")
            } else {
                self.alert?.getAlert(title: "Sucesso!", message: "Usuário cadastrado com sucesso.", completion: {
                    self.navigationController?.popViewController(animated: true)
                })
            }
        })
    }
}
