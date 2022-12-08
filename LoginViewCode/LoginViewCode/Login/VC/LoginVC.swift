//
//  ViewController.swift
//  LoginViewCode
//
//  Created by Frédéric Helfer on 06/12/22.
//

import UIKit
import FirebaseAuth

class LoginVC: UIViewController {

    var loginScreen: LoginScreen?
    var auth = Auth.auth()
    var alert: Alert?
    
    override func loadView() {
        loginScreen = LoginScreen()
        view = loginScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginScreen?.delegate(delegate: self)
        loginScreen?.configTextFieldDelegate(delegate: self)
        self.alert = Alert(controller: self)
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
}

extension LoginVC: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        loginScreen?.validaTextField()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension LoginVC: LoginScreenProtocol {
    
    func actionLoginButton() {
        let vc = HomeVC()
        present(vc, animated: true)
        
//        guard
//            let email = loginScreen?.emailTextField.text,
//            let password = loginScreen?.passwordTextField.text else {
//            return
//        }
//
//        auth.signIn(withEmail: email, password: password) { result, error in
//            if error != nil {
//                self.alert?.getAlert(title: "Atenção!", message: "Dados incorretos, verifique e tente novamente.")
//            } else {
//
//                if result == nil {
//                    self.alert?.getAlert(title: "Atenção!", message: "Tivemos um problema inesperado, tente novamente mais tarde.")
//                } else {
//                    self.alert?.getAlert(title: "Sucesso!", message: "Usuário logado com sucesso.")
//                }
//            }
//        }
    }
    
    func actionRegisterButton() {
        let vc = RegisterVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

