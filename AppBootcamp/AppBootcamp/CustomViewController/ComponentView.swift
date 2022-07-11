//
//  ComponentView.swift
//  AppBootcamp
//
//  Created by Matheus Lenke on 08/07/22.
//

import UIKit
import SnapKit

class ComponentView: UIView {

    lazy var imageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.backgroundColor = .orange
        view.layer.cornerRadius = 40
        view.layer.cornerCurve = .continuous
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var labelView: UILabel = {
        let view = UILabel(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        view.text = "Hello World"
        return view
    }()
    
    lazy var view: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        view.layer.cornerRadius = 15
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ComponentView: ViewCode {
    func buildHierarchy() {
        addSubview(labelView)
        addSubview(imageView)
        imageView.addSubview(view)
    }
    
    func setupConstraint() {
        labelView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.left.equalTo(imageView.snp.left)
            make.right.equalTo(imageView.snp.right)
            make.bottom.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.height.width.equalTo(100)
            make.top.right.left.equalToSuperview()
        }
        
        view.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.top.left.equalTo(imageView).offset(10)
            make.right.bottom.equalTo(imageView).offset(-10)
        }
    }
    
    func setupConfiguration() {
        self.backgroundColor = .gray
    }
}
