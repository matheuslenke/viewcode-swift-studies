//
//  DataModel.swift
//  UsersRxSwift
//
//  Created by Matheus Lenke on 27/06/22.
//

import Foundation

struct DataModel: Codable {
    let page: Int?
    let per_page: Int?
    let total: Int?
    let total_page: Int?
    let data: [UserDetail]?
}

struct UserDetail: Codable {
    let id: Int?
    let email: String?
    let first_name: String?
    let last_name: String?
    let avatar: String?
}
