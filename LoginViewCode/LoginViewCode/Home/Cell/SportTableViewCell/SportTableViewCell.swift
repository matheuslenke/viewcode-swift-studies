//
//  SportTableViewCell.swift
//  LoginViewCode
//
//  Created by Matheus Lenke on 27/04/22.
//

import UIKit

class SportTableViewCell: UITableViewCell {
    
    var sportTableViewCellScreen = SportTableViewCellScreen()
    var data: [Sport] = []
    static let identifier = "SportTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.customAddSubview()
        self.configConstraintsSportTableViewCellScreen()
        self.sportTableViewCellScreen.configProtocolsCollectionView(delegate: self, dataSource: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func customAddSubview() {
        self.sportTableViewCellScreen.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(self.sportTableViewCellScreen)
    }
    
    public func dataCollection(data: [Sport]) {
        self.data = data
    }
    
    private func configConstraintsSportTableViewCellScreen() {
        self.sportTableViewCellScreen.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension SportTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SportCollectionViewCell.identifier, for: indexPath) as? SportCollectionViewCell else { return UICollectionViewCell()}
        let sport = self.data[indexPath.row]
        cell.setupCell(data: sport)
        return cell
    }
}

extension SportTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 100)
    }
}
