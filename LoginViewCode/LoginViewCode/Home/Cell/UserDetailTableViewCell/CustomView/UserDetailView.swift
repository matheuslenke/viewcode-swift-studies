//
//  UserDetailView.swift
//  LoginViewCode
//
//  Created by Matheus Lenke on 27/04/22.
//

import UIKit

class UserDetailView: UIView {
    lazy var userImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.addSubview(userImageView)
        self.addSubview(nameLabel)
        
        configUserImageViewConstraints()
        configNameLabelConstraints()
    }
    
    private func configUserImageViewConstraints() {
        self.userImageView.snp.makeConstraints { make in
            make.centerY.leading.equalToSuperview()
            make.height.width.equalTo(80)
        }
    }
    
    private func configNameLabelConstraints() {
        self.nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(self.userImageView.snp.trailing).offset(20)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(10)
        }
    }
    
    public func setNameLabel(name: String) {
        self.nameLabel.text = name
    }
    
    public func setUserImageView(imageName: String) {
        self.userImageView.image = UIImage(systemName: "person")
    }
}
