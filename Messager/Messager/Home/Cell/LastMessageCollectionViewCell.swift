//
//  LastMessageCollectionViewCell.swift
//  Messager
//
//  Created by Frédéric Helfer on 12/12/22.
//

import UIKit

class LastMessageCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "LastMessageCollectionViewCell"
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = false
        image.image = UIImage(systemName: "person.badge.plus")
        return image
    }()
    
    lazy var userName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Adicionar novo Contato"
        label.font = UIFont(name: CustomFont.poppinsMedium, size: 16)
        label.textColor = .darkGray
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
}
