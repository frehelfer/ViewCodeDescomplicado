//
//  UserDetailView.swift
//  LoginViewCode
//
//  Created by Frédéric Helfer on 07/12/22.
//

import UIKit

class UserDetailView: UIView {
    
    lazy var userImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addElements()
        configUserImageViewConstraints()
        configNameLabelConstraints()
    }
    
    private func addElements() {
        addSubview(userImageView)
        addSubview(nameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUserImageViewConstraints() {
        userImageView.snp.makeConstraints { make in
            make.centerY.leading.equalToSuperview()
            make.height.width.equalTo(80)
        }
    }
    
    private func configNameLabelConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(userImageView.snp.trailing).offset(20)
        }
    }
    
}
