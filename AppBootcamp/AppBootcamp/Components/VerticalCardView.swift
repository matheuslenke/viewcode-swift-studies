//
//  VerticalCardView.swift
//  AppBootcamp
//
//  Created by Matheus Lenke on 08/07/22.
//

import UIKit

class VerticalCardView: UIView {
    lazy var greenSquare: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var orangeRectangle: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var redRectangle: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension VerticalCardView: ViewCode {
    func buildHierarchy() {
        addSubview(verticalStack)
        verticalStack.addArrangedSubview(greenSquare)
        verticalStack.addArrangedSubview(orangeRectangle)
        verticalStack.addArrangedSubview(redRectangle)
    }
    
    func setupConstraint() {
        self.snp.makeConstraints { make in
            make.width.equalTo(80)
        }
        
        greenSquare.snp.makeConstraints { make in
            make.width.height.equalTo(80)
        }
        
        verticalStack.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
        
        orangeRectangle.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        redRectangle.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
    }
    
    func setupConfiguration() {
    }
}
