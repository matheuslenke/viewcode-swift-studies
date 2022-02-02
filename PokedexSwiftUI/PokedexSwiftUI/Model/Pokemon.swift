//
//  Pokemon.swift
//  PokedexSwiftUI
//
//  Created by Matheus Lenke on 01/02/22.
//

import Foundation

struct Pokemon: Decodable, Identifiable {
    let id: Int
    let name: String
    let imageUrl: String
    let type: String
}


let MOCK_POKEMON: [Pokemon] = [
    .init(id: 0, name: "Bulbassaur", imageUrl: "1", type: "poison"),
    .init(id: 1, name: "Bulbassaur", imageUrl: "1", type: "poison"),
    .init(id: 2, name: "Bulbassaur", imageUrl: "1", type: "poison"),
    .init(id: 3, name: "Pikachu", imageUrl: "1", type: "fire"),
    .init(id: 4, name: "Charmander", imageUrl: "1", type: "grass"),
    .init(id: 5, name: "Bulbassaur", imageUrl: "1", type: "poison"),
    .init(id: 6, name: "Bulbassaur", imageUrl: "1", type: "poison"),
    .init(id: 7, name: "Bulbassaur", imageUrl: "1", type: "poison"),
    .init(id: 8, name: "Bulbassaur", imageUrl: "1", type: "poison"),
    .init(id: 9, name: "Bulbassaur", imageUrl: "1", type: "poison")
]
