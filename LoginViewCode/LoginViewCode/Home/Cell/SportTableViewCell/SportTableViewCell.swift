//
//  SportTableViewCell.swift
//  LoginViewCode
//
//  Created by Frédéric Helfer on 08/12/22.
//

import UIKit

class SportTableViewCell: UITableViewCell {
    
    var sportTableViewScreen = SportTableViewCellScreen()
    var data: [Sport] = []
    
    static let identifier: String = "SportTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        sportTableViewScreen.configProtocolsCollectionView(delegate: self, dataSource: self)
        addElements()
        configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addElements() {
        contentView.addSubview(sportTableViewScreen)
    }
    
    func configConstraints() {
        sportTableViewScreen.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func dataCollection(data: [Sport]) {
        self.data = data
    }
    
}

extension SportTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell: SportCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: SportCollectionViewCell.identifier, for: indexPath) as? SportCollectionViewCell else {
            fatalError("Error creating sportCollectionViewCell")
        }
        cell.setupCell(data: data[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 100)
    }
    
}
