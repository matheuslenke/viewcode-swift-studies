//
//  HorizontalCardView.swift
//  AppBootcamp
//
//  Created by Matheus Lenke on 08/07/22.
//

import UIKit

class HorizontalCardView: UIView {
    lazy var greenSquare: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
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
    
    lazy var horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 30
        stack.distribution = .fillEqually
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var pinkRectangle: UIView = {
        let view = UIView()
        view.backgroundColor = .systemPink
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var blueRectangle: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
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

extension HorizontalCardView: ViewCode {
    func buildHierarchy() {
        addSubview(greenSquare)
        addSubview(verticalStack)
        
        verticalStack.addArrangedSubview(orangeRectangle)
        verticalStack.addArrangedSubview(redRectangle)
        verticalStack.addArrangedSubview(horizontalStack)

        horizontalStack.addArrangedSubview(pinkRectangle)
        horizontalStack.addArrangedSubview(blueRectangle)
    }
    
    func setupConstraint() {
        self.snp.makeConstraints { make in
            make.height.equalTo(80)
        }
        
        greenSquare.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(90)
        }
        
        verticalStack.snp.makeConstraints { make in
            make.left.equalTo(greenSquare.snp.right).offset(5)
            make.top.bottom.right.equalToSuperview()
        }
    }
    
    func setupConfiguration() {
    }
}
