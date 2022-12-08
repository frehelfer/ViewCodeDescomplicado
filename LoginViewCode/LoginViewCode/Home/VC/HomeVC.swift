//
//  HomeVC.swift
//  LoginViewCode
//
//  Created by Frédéric Helfer on 07/12/22.
//

import UIKit

class HomeVC: UIViewController {
    
    var homeScreen: HomeScreen?
    var data: [DataUser] = [
        DataUser(name: "Fre", nameImage: "person.fill"),
        DataUser(name: "Besh", nameImage: "person.fill.badge.plus"),
        DataUser(name: "Tany", nameImage: "person.circle.fill")
    ]
    
    var dataSport: [Sport] = [
        Sport(name: "Corrida", imageName: "person.fill"),
        Sport(name: "Natação", imageName: "person.fill.badge.plus"),
        Sport(name: "Ioga", imageName: "person.circle.fill")
    ]
    
    override func loadView() {
        homeScreen = HomeScreen()
        view = homeScreen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        homeScreen?.configTableViewDelegate(delegate: self, dataSource: self)
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 3 {
            guard let cell: SportTableViewCell = tableView.dequeueReusableCell(withIdentifier: SportTableViewCell.identifier, for: indexPath) as? SportTableViewCell else {
                fatalError("Error creating TableViewCell")
            }
            cell.dataCollection(data: dataSport)
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserDetailCell.identifier, for: indexPath) as? UserDetailCell else {
            fatalError("Error creating TableViewCell")
        }
        cell.setUpCell(data: data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
}
