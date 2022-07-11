//
//  UserViewModel.swift
//  UsersRxSwift
//
//  Created by Matheus Lenke on 27/06/22.
//

import Foundation
import RxSwift
import RxCocoa

struct UserDetailModel {
    var userData = UserDetail(id: 1, email: "abc@gmail.com", first_name: "Matheus", last_name: "Lenke", avatar: "avatar")
    var isFavorite: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    var isFavObservable: Observable<Bool> {
        return isFavorite.asObservable()
    }
}


class UserViewModel {
    let request = APIRequest()
    var users: Observable<[UserDetail]>?
    private let userViewModel = BehaviorRelay<[UserDetailModel]>(value: [])
    var userViewModelObserver: Observable<[UserDetailModel]> {
        return userViewModel.asObservable()
    }
    
    private let disposeBag = DisposeBag()
    
    func fetchUserList() {
        users = request.callAPI()
        users?.subscribe(onNext: { (value) in
            var userViewModelArray = [UserDetailModel]()
            for index in 0..<value.count {
                var user = UserDetailModel()
                user.userData = value[index]
                userViewModelArray.append(user)
            }
            self.userViewModel.accept(userViewModelArray)
        }, onError: { error in
            _ = self.userViewModel.catch({ error in
                Observable.empty()
            })
            print(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
}
