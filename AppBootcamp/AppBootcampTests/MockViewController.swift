//
//  MockViewController.swift
//  AppBootcampTests
//
//  Created by Matheus Lenke on 11/07/22.
//

import UIKit

class MockViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public func configureMockView(mockView: UIView) {
        self.view.addSubview(mockView)
        
        mockView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
        }
    }
    
}
