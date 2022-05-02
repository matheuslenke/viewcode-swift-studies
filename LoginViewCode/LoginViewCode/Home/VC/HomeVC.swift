//
//  HomeVC.swift
//  LoginViewCode
//
//  Created by Matheus Lenke on 27/04/22.
//

import UIKit

class HomeVC: UIViewController {
    
    var homeScreen: HomeScreen?
    var userData: [DataUser] = [
        DataUser(name: "Lenke", nameImage: "menino1"),
        DataUser(name: "Ryan", nameImage: "menino2"),
        DataUser(name: "Angela", nameImage: "menina1")
    ]
    
    var sportsData: [Sport] = [
        Sport(name: "Corrida", imageName: "corrida"),
        Sport(name: "Ciclismo", imageName: "corrida"),
        Sport(name: "Natação", imageName: "corrida"),
        Sport(name: "Yoga", imageName: "corrida"),
    ]

    override func loadView() {
        self.homeScreen = HomeScreen()
        self.view = homeScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.homeScreen?.configTableViewProtocol(delegate: self, dataSource: self)

    }
}

extension HomeVC: UITableViewDelegate {
    
}

extension HomeVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userData.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == self.userData.count {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SportTableViewCell.identifier, for: indexPath) as? SportTableViewCell else { return UITableViewCell() }
            cell.dataCollection(data: sportsData)
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserDetailTableViewCell.identifier, for: indexPath) as? UserDetailTableViewCell else { return UITableViewCell()}
        cell.setupCell(data: userData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
}
