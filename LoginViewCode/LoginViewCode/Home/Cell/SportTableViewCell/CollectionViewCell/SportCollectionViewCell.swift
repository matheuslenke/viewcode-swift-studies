//
//  SportCollectionViewCell.swift
//  LoginViewCode
//
//  Created by Matheus Lenke on 02/05/22.
//

import UIKit

class SportCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SportCollectionViewCell"
    
    let sportCollectionViewCellScreen = SportCollectionViewCellScreen()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.customAddSubview()
        self.configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupCell(data: Sport) {
        self.sportCollectionViewCellScreen.layer.borderWidth = 6.0
        self.sportCollectionViewCellScreen.layer.borderColor = UIColor.blue.cgColor
        self.sportCollectionViewCellScreen.imageView.image = UIImage(named: data.imageName)
        self.sportCollectionViewCellScreen.sportName.text = data.name
    }
    
    private func customAddSubview() {
        self.sportCollectionViewCellScreen.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.sportCollectionViewCellScreen)
    }
    
    private func configConstraints() {
        sportCollectionViewCellScreen.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
