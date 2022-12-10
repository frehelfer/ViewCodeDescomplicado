//
//  RegisterScreen.swift
//  LoginViewCode
//
//  Created by Frédéric Helfer on 06/12/22.
//

import UIKit

protocol RegisterScreenProtocol: AnyObject {
    func actionRegisterButton()
}

class RegisterScreen: UIView {
    
    private weak var delegate: RegisterScreenProtocol?
    
    public func delegate(delegate: RegisterScreenProtocol?) {
        self.delegate = delegate
    }
    
    lazy var backButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "back"), for: .normal)
        return btn
    }()
    
    lazy var imageAddUser: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "usuario")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var nameTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocorrectionType = .no
        tf.backgroundColor = .white
        tf.borderStyle = .roundedRect
        tf.keyboardType = .emailAddress
        tf.placeholder = "Digite seu nome:"
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.textColor = .darkGray
        return tf
    }()
    
    lazy var emailTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocorrectionType = .no
        tf.backgroundColor = .white
        tf.borderStyle = .roundedRect
        tf.keyboardType = .emailAddress
        tf.placeholder = "Digite seu email:"
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.textColor = .darkGray
        return tf
    }()
    
    lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocorrectionType = .no
        tf.backgroundColor = .white
        tf.borderStyle = .roundedRect
        tf.keyboardType = .default
        tf.isSecureTextEntry = true
        tf.placeholder = "Digite sua senha:"
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.textColor = .darkGray
        return tf
    }()
    
    lazy var registerButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Cadastrar", for: .normal)
        btn.setTitleColor(.lightGray, for: .normal)
        btn.isEnabled = false
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 7.5
        btn.backgroundColor = UIColor(red: 3/255, green: 58/255, blue: 51/255, alpha: 1.0)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btn.addTarget(self, action: #selector(tappedRegisterButton), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        addView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private API
    
    private func addView() {
        addSubview(backButton)
        addSubview(imageAddUser)
        addSubview(nameTextField)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(registerButton)
        
        NSLayoutConstraint.activate([

            imageAddUser.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            imageAddUser.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageAddUser.widthAnchor.constraint(equalToConstant: 150),
            imageAddUser.heightAnchor.constraint(equalToConstant: 150),
            
            nameTextField.topAnchor.constraint(equalTo: imageAddUser.bottomAnchor, constant: 15),
            nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 45),
            
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 15),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 45),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 15),
            passwordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: emailTextField.heightAnchor),

            registerButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            registerButton.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            registerButton.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            registerButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func setupView() {
        backgroundColor = UIColor(red: 24/255, green: 117/255, blue: 104/255, alpha: 1.0)
    }
    
    // MARK: - Actions
    
    @objc private func tappedRegisterButton() {
        delegate?.actionRegisterButton()
    }
    
    // MARK: - Public API
    
    public func configTextFieldDelegate(delegate: UITextFieldDelegate) {
        nameTextField.delegate = delegate
        emailTextField.delegate = delegate
        passwordTextField.delegate = delegate
    }
    
    public func validaTextField() {
        let name = nameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        if !name.isEmpty && !email.isEmpty && !password.isEmpty {
            configureButtonEnable(true)
        } else {
            configureButtonEnable(false)
        }
    }
    
    private func configureButtonEnable(_ enable: Bool) {
        if enable {
            registerButton.setTitleColor(.white, for: .normal)
            registerButton.isEnabled = true
        } else {
            registerButton.setTitleColor(.lightGray, for: .normal)
            registerButton.isEnabled = false
        }
    }
}

