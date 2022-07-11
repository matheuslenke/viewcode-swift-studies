//
//  BigCardView.swift
//  AppBootcamp
//
//  Created by Matheus Lenke on 08/07/22.
//

import UIKit

class BigCardView: UIView {
    lazy var horizontalCardView = HorizontalCardView(frame: .zero)
    
    lazy var horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 20
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var verticalCardOne = VerticalCardView(frame: .zero)
    lazy var verticalCardTwo = VerticalCardView(frame: .zero)
    lazy var verticalCardThree = VerticalCardView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BigCardView: ViewCode {
    func buildHierarchy() {
        self.addSubview(horizontalCardView)
        self.addSubview(horizontalStack)

        horizontalStack.addArrangedSubview(verticalCardOne)
        horizontalStack.addArrangedSubview(verticalCardTwo)
        horizontalStack.addArrangedSubview(verticalCardThree)
    }
    
    func setupConstraint() {
        horizontalCardView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        horizontalStack.snp.makeConstraints { make in
            make.top.equalTo(horizontalCardView.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
    }
    
    func setupConfiguration() {
        self.backgroundColor = .blue
        self.layer.cornerRadius = 10
    }
}
