//
//  ChatViewController.swift
//  MessengerApp
//
//  Created by Matheus Lenke on 10/05/22.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @objc func tappedBackButton() {
        self.navigationController?.popToRootViewController(animated: true)
    }

}
