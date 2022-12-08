//
//  SportCollectionVIewCellScreen.swift
//  LoginViewCode
//
//  Created by Frédéric Helfer on 08/12/22.
//

import UIKit

class SportCollectionVIewCellScreen: UIView {
    
    lazy var backgrounImage: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray.withAlphaComponent(0.5)
        view.layer.cornerRadius = 20
        return view
    }()

    lazy var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addElements()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addElements() {
        addSubview(backgrounImage)
        addSubview(image)
        addSubview(label)
    }
    
    func configConstraints() {
        
        backgrounImage.snp.makeConstraints { make in
            make.top.equalTo(snp_topMargin).offset(13)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(40)
        }
        
        image.snp.makeConstraints { make in
            make.top.equalTo(snp_topMargin).offset(13)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(40)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(image.snp_bottomMargin).offset(15)
            make.centerX.equalToSuperview()
        }
    }
}
