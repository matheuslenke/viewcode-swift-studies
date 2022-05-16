//
//  IncomingTextMessageTableViewCell.swift
//  MessengerApp
//
//  Created by Matheus Lenke on 16/05/22.
//

import UIKit

class IncomingTextMessageTableViewCell: UITableViewCell {
    
    static let identifier = "IncomingTextMessageTableViewCell"
    
    lazy var contactMessage: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.06)
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var messageTextLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .darkGray
        label.font = UIFont(name: CustomFont.poppinsMedium, size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addElements()
        setupConstraints()
    }
    
    private func addElements() {
        self.addSubview(self.contactMessage)
        self.contactMessage.addSubview(self.messageTextLabel)
        self.isSelected = false
    }
    
    private func setupConstraints() {
        messageTextLabel.transform = CGAffineTransform(scaleX: 1, y: -1)
        NSLayoutConstraint.activate([
            self.contactMessage.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 20),
            self.contactMessage.topAnchor.constraint(equalTo: self.topAnchor,constant: 10),
            self.contactMessage.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            
            self.messageTextLabel.leadingAnchor.constraint(equalTo: self.contactMessage.leadingAnchor,constant: 15),
            self.messageTextLabel.topAnchor.constraint(equalTo: self.contactMessage.topAnchor,constant: 15),
            self.messageTextLabel.bottomAnchor.constraint(equalTo: self.contactMessage.bottomAnchor,constant: -15),
            self.messageTextLabel.trailingAnchor.constraint(equalTo: self.contactMessage.trailingAnchor,constant: -15),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setupCell(message: Message?) {
        self.messageTextLabel.text = message?.texto ?? ""
    }
    
}
