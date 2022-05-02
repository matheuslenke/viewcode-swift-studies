//
//  SportTableViewCellScreen.swift
//  LoginViewCode
//
//  Created by Matheus Lenke on 27/04/22.
//

import UIKit

class SportTableViewCellScreen: UIView {

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.init())
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delaysContentTouches = false
        collectionView.register(SportCollectionViewCell.self, forCellWithReuseIdentifier: SportCollectionViewCell.identifier)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.setCollectionViewLayout(layout, animated: false)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.customAddSubview()
        self.configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configProtocolsCollectionView(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        self.collectionView.delegate = delegate
        self.collectionView.dataSource = dataSource
    }
    
    private func customAddSubview() {
        self.addSubview(collectionView)
    }
    
    private func configConstraints() {
        self.collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
