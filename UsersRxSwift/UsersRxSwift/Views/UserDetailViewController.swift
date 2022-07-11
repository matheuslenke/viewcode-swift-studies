//
//  UserDetailViewController.swift
//  UsersRxSwift
//
//  Created by Matheus Lenke on 27/06/22.
//

import UIKit
import RxSwift
import RxCocoa

class UserDetailsViewController: UIViewController {

    @IBOutlet var idNumberLabel: UILabel!
    @IBOutlet var fullNameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var starButton: UIButton!
    
    private let disposeBag = DisposeBag()
    var userDetail = BehaviorRelay<UserDetailModel>(value: UserDetailModel())
    var userDetailObserver: Observable<UserDetailModel> {
        return userDetail.asObservable()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
