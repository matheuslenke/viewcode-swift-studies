//
//  UserCell.swift
//  UsersRxSwift
//
//  Created by Matheus Lenke on 27/06/22.
//

import UIKit

class UserCell: UITableViewCell {
    static let starTintColor = UIColor(red: 212/255, green: 163/255, blue: 50/255, alpha: 1.0)
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    public func configureCell(userDetail: UserDetailModel) {
        nameLabel.text = userDetail.userData.first_name ?? ""
        
        if userDetail.isFavorite.value {
            favoriteButton.setBackgroundImage(UIImage(systemName: "star.fill")?.withTintColor(UserCell.starTintColor), for: .normal)
        } else {
            favoriteButton.setBackgroundImage(UIImage(systemName: "star")?.withTintColor(UserCell.starTintColor), for: .normal)
        }
    }
}
