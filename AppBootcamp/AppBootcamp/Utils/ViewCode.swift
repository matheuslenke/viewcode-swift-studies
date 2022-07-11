//
//  ViewCode.swift
//  AppBootcamp
//
//  Created by Matheus Lenke on 08/07/22.
//

import Foundation

protocol ViewCode {
    func buildHierarchy() // Adicionar as views na tela
    func setupConstraint() // Configurar as constraints dessa view
    func setupConfiguration() // Quaisquer configurações adicionais necessárias
}

extension ViewCode {
    func setupView() {
        buildHierarchy()
        setupConstraint()
        setupConfiguration()
    }
}
