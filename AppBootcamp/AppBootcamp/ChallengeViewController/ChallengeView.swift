//
//  ChallengeView.swift
//  AppBootcamp
//
//  Created by Matheus Lenke on 08/07/22.
//

import UIKit

class ChallengeView: UIView {
    
    lazy var bigCardView = BigCardView(frame: .zero)
    
    lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("SomeAction", for: .normal)
        button.backgroundColor = .red
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        return button
    }()
    
    lazy var horizontalCardView = HorizontalCardView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ChallengeView: ViewCode {
    func buildHierarchy() {
        self.addSubview(bigCardView)
        self.addSubview(actionButton)
    }
    
    func setupConstraint() {
        NSLayoutConstraint.activate([
            bigCardView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            bigCardView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            bigCardView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            bigCardView.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -10),
            
            actionButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            actionButton.leftAnchor.constraint(equalTo: bigCardView.leftAnchor),
            actionButton.rightAnchor.constraint(equalTo: bigCardView.rightAnchor),
            actionButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    func setupConfiguration() {
        self.backgroundColor = .lightGray
    }
}
