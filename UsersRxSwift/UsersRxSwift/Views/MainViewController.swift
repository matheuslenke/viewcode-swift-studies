//
//  ViewController.swift
//  UsersRxSwift
//
//  Created by Matheus Lenke on 27/06/22.
//

import UIKit
import RxRelay
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    
    fileprivate let bag = DisposeBag()
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var tableView: UITableView!
    
    let userViewModel = UserViewModel()
    
    var userList = BehaviorRelay<[UserDetailModel]>(value: [])
    var filteredList = BehaviorRelay<[UserDetailModel]>(value: [])
    var controller: UserDetailsViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userViewModel.fetchUserList()
        controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "UserDetailController") as UserDetailsViewController
        bindUI()
    }
    
    private func bindUI() {
        userViewModel.userViewModelObserver.subscribe(onNext: { value in
            self.filteredList.accept(value)
            self.userList.accept(value)
        }).disposed(by: bag)
        
        filteredList.bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UserCell.self)) { row, model, cell in
            cell.configureCell(userDetail: model)
        }.disposed(by: bag)
        
        tableView.tableFooterView = UIView()
        
        //Replacement to didSelectRowAt() of tableview delegate functions
        tableView.rx.itemSelected.subscribe(onNext: { indexPath in
            self.tableView.deselectRow(at: indexPath, animated: true)
            self.controller?.userDetail.accept(self.filteredList.value[indexPath.row])
            self.controller?.userDetail.value.isFavObservable.subscribe(onNext: { _ in
                self.tableView.reloadData()
            }).disposed(by: self.bag)
            self.navigationController?.pushViewController(self.controller ?? UserDetailsViewController(), animated: true)
        }).disposed(by: bag)
        
        //Search functionality: Combines the complete data model to search field and binds results to data model binded to the tableview.
        Observable.combineLatest(userList.asObservable(), searchTextField.rx.text, resultSelector: { users, search in
            return users.filter { (user) -> Bool in
                self.filterUserList(userModel: user, searchText: search)
            }
        }).bind(to: filteredList).disposed(by: bag)
    }
    
    //Search function
    func filterUserList(userModel: UserDetailModel, searchText: String?) -> Bool {
        if let search = searchText, !search.isEmpty, !(userModel.userData.first_name?.contains(search) ?? false) {
            return false
        }
        return true
    }
    
    func errorAlert() {
        let alert = UIAlertController(title: "Error", message: "Check your Internet connection and Try Again!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
