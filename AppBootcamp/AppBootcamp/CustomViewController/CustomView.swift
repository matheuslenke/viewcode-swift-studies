//
//  CustomView.swift
//  AppBootcamp
//
//  Created by Matheus Lenke on 08/07/22.
//

import UIKit
import SnapKit

class CustomView: UIView {
    
    lazy var componentView = ComponentView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomView: ViewCode {
    func buildHierarchy() {
        addSubview(componentView)
    }
    
    func setupConstraint() {
        componentView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    func setupConfiguration() {
        self.backgroundColor = .gray
    }
}
