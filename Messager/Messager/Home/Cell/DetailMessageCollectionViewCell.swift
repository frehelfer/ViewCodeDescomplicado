//
//  DetailMessageCollectionViewCell.swift
//  Messager
//
//  Created by Frédéric Helfer on 12/12/22.
//

import UIKit

class DetailMessageCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "DetailMessageCollectionViewCell"
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.layer.cornerRadius = 26
        image.image = UIImage(systemName: "imagem-perfil")
        return image
    }()
    
    lazy var userName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: addElements
    private func addElements() {
        addSubview(imageView)
        addSubview(userName)
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            imageView.widthAnchor.constraint(equalToConstant: 55),
            imageView.heightAnchor.constraint(equalToConstant: 55),
            
            userName.centerYAnchor.constraint(equalTo: centerYAnchor),
            userName.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15),
            userName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    // MARK: Public API
    
    func setupView(contact: Contact) {
        guard let name = contact.name else { return }
        
        let attributeText = NSMutableAttributedString(string: name, attributes: [
            NSAttributedString.Key.font: UIFont(name: CustomFont.poppinsMedium, size: 16) ?? UIFont(),
            NSAttributedString.Key.foregroundColor: UIColor.darkGray
        ])
        
        self.userName.attributedText = attributeText
    }
    
    func setupView(conversation: Conversation) {
        guard
            let name = conversation.name,
            let lastMessage = conversation.lastMessage else {
        return }
        
        let attributeText = NSMutableAttributedString(string: name, attributes: [
            NSAttributedString.Key.font: UIFont(name: CustomFont.poppinsMedium, size: 16) ?? UIFont(),
            NSAttributedString.Key.foregroundColor: UIColor.darkGray
        ])
        
        attributeText.append(NSMutableAttributedString(string: "\n\(lastMessage)", attributes: [
            NSAttributedString.Key.font: UIFont(name: CustomFont.poppinsMedium, size: 14) ?? UIFont(),
            NSAttributedString.Key.foregroundColor: UIColor.lightGray
        ]))
        
        self.userName.attributedText = attributeText
    }
}
