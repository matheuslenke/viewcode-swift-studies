//
//  CustomViewController.swift
//  AppBootcamp
//
//  Created by Matheus Lenke on 08/07/22.
//

import UIKit

class CustomViewController: UIViewController {

    override func loadView() {
        super.loadView()
        self.view = CustomView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
