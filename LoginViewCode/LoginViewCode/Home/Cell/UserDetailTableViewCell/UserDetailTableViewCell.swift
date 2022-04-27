//
//  UserDetailTableViewCell.swift
//  LoginViewCode
//
//  Created by Matheus Lenke on 27/04/22.
//

import UIKit
import SnapKit

class UserDetailTableViewCell: UITableViewCell {
    
    static let identifier = "UserDetailTableViewCell"
    
    lazy var userDetailView: UserDetailView = {
        let view = UserDetailView()
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.customAddSubview()
        self.configConstraintsDescriptionCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func customAddSubview() {
        self.contentView.addSubview(self.userDetailView)
    }
    
    private func configConstraintsDescriptionCell() {
        self.userDetailView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    public func setupCell(data: DataUser) {
        userDetailView.setNameLabel(name: data.name)
        userDetailView.setUserImageView(imageName: data.nameImage)
    }
    
}
