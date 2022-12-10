//
//  NavView.swift
//  Messager
//
//  Created by Frédéric Helfer on 10/12/22.
//

import UIKit

enum TypeConversationOrContact {
    case conversation, contact
}

protocol NavViewProtocol: AnyObject {
    func typeScreenMessage(type: TypeConversationOrContact)
}

class NavView: UIView {
    
    weak private var delegate: NavViewProtocol?
    func delegate(delegate: NavViewProtocol?) {
        self.delegate = delegate
    }
    
    lazy var navBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 35
        view.layer.maskedCorners = [.layerMaxXMaxYCorner]
        view.layer.shadowColor = UIColor(white: 0, alpha: 0.02).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 10
        return view
    }()
    
    lazy var navBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var searchBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = CustomColor.appLight
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()
    
    lazy var searchLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Digite Aqui"
        label.font = UIFont(name: CustomFont.poppinsMedium, size: 16)
        return label
    }()
    
    lazy var searchButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "search"), for: .normal)
        // TODO: Target
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.spacing = 10
        return stack
    }()
    
    lazy var conversationButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "message")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .systemPink
        button.addTarget(self, action: #selector(tappedConversationButton), for: .touchUpInside)
        return button
    }()
    
    lazy var contactButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "group")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(tappedContactButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        addElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Actions
    @objc func tappedConversationButton() {
        delegate?.typeScreenMessage(type: .conversation)
        conversationButton.tintColor = .systemPink
        contactButton.tintColor = .black
    }
    
    @objc func tappedContactButton() {
        delegate?.typeScreenMessage(type: .contact)
        conversationButton.tintColor = .black
        contactButton.tintColor = .systemPink
    }
    
    // MARK: addElements
    func addElements() {
        
        addSubview(navBackgroundView)
        navBackgroundView.addSubview(navBar)
        navBar.addSubview(searchBar)
        navBar.addSubview(stackView)
        searchBar.addSubview(searchLabel)
        searchBar.addSubview(searchButton)
        stackView.addArrangedSubview(conversationButton)
        stackView.addArrangedSubview(contactButton)
        
        NSLayoutConstraint.activate([
            navBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            navBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            navBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            navBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            navBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            navBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            navBar.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            searchBar.centerYAnchor.constraint(equalTo: navBar.centerYAnchor),
            searchBar.leadingAnchor.constraint(equalTo: navBar.leadingAnchor, constant: 30),
            searchBar.trailingAnchor.constraint(equalTo: navBar.leadingAnchor, constant: -20),
            searchBar.heightAnchor.constraint(equalToConstant: 55),
            
            stackView.centerYAnchor.constraint(equalTo: navBar.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: navBar.trailingAnchor, constant: -30),
            stackView.widthAnchor.constraint(equalToConstant: 100),
            stackView.heightAnchor.constraint(equalToConstant: 30),
            
            searchLabel.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor, constant: 25),
            searchLabel.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            
            searchButton.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: -20),
            searchButton.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: 20),
            searchButton.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}
