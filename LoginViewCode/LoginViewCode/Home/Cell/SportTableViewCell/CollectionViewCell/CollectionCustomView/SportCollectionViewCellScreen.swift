//
//  SportCollectionViewCellScreen.swift
//  LoginViewCode
//
//  Created by Matheus Lenke on 02/05/22.
//

import UIKit

class SportCollectionViewCellScreen: UIView {
    
    lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var sportName: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.customAddSubview()
        self.configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func customAddSubview() {
        self.addSubview(self.imageView)
        self.addSubview(self.sportName)
    }

    private func configConstraints() {
        self.imageView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(10)
            make.leading.equalTo(self.snp.leading).offset(10)
            make.trailing.equalTo(self.snp.trailing).inset(10)
            make.bottom.equalTo(self.sportName.snp.top).inset(10)
        }
        
        self.sportName.snp.makeConstraints { make in
            make.leading.equalTo(self.snp.leading).offset(10)
            make.trailing.equalTo(self.snp.trailing).inset(10)
            make.bottom.equalTo(self.snp.bottom).inset(10)
            make.height.equalTo(20)
        }
    }
    
}
