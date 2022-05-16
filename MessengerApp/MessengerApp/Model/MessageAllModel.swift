//
//  MessageAllModel.swift
//  MessengerApp
//
//  Created by Matheus Lenke on 06/05/22.
//

import Foundation

struct Message {
    let texto: String
    let idUsuario: String
}

struct Conversation {
    let nome: String
    let ultimaMensagem: String?
    let idDestinatario: String
}

struct User {
    let nome: String
    let email: String
}

struct Contact {
    let id: String
    let nome: String
}
