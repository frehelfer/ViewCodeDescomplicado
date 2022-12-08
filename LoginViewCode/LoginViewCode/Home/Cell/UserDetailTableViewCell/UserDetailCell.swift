//
//  UserDetailCell.swift
//  LoginViewCode
//
//  Created by Frédéric Helfer on 07/12/22.
//

import UIKit

class UserDetailCell: UITableViewCell {
    
    static let identifier: String = "UserDetailCell"
    
    lazy var userDetailView: UserDetailView = {
        let view = UserDetailView()
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addElements()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElements() {
        contentView.addSubview(userDetailView)
    }
    
    public func setUpCell(data: DataUser) {
        userDetailView.nameLabel.text = data.name
        userDetailView.userImageView.image = UIImage(systemName: data.nameImage)
    }
    
    private func configConstraints() {
        userDetailView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
