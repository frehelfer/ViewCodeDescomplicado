//
//  SportCollectionViewCell.swift
//  LoginViewCode
//
//  Created by Frédéric Helfer on 08/12/22.
//

import UIKit

class SportCollectionViewCell: UICollectionViewCell {
    
    let sportCollectionVIewCellScreen = SportCollectionVIewCellScreen()
    
    static let identifier = "SportCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addElements()
        configConstraints()
    }
    
    public func setupCell(data: Sport) {
        sportCollectionVIewCellScreen.image.image = UIImage(systemName: data.imageName)
        sportCollectionVIewCellScreen.label.text = data.name
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func addElements() {
        sportCollectionVIewCellScreen.layer.borderColor = UIColor.blue.cgColor
        sportCollectionVIewCellScreen.layer.borderWidth = 0.5
        sportCollectionVIewCellScreen.layer.cornerRadius = 20
        contentView.addSubview(sportCollectionVIewCellScreen)
    }
    
    func configConstraints() {
        sportCollectionVIewCellScreen.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
