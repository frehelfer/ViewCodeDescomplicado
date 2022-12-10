//
//  HomeVC.swift
//  Messager
//
//  Created by Frédéric Helfer on 10/12/22.
//

import UIKit
import Firebase

class HomeVC: UIViewController {
    
    var auth: Auth?
    var db: Firestore?
    
    var contactScreen: Bool?
    var userIdLogged: String?
    var userEmailLogged: String?
    
    var alert: Alert?
    
    let homeView = HomeView()
    
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        configHomeView()
    }
    
    private func configHomeView() {
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = CustomColor.appLight
        
        homeView.navView.delegate(delegate: self)
        homeView.delegateCollectionView(delegate: self, dataSource: self)
        
        alert = Alert(controller: self)
    }
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }
}

extension HomeVC: NavViewProtocol {
    func typeScreenMessage(type: TypeConversationOrContact) {
        switch type {
        case .contact:
            contactScreen = true
        case .conversation:
            contactScreen = false
        }
    }
}
