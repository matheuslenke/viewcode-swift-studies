//
//  DetailViewController.swift
//  Calc
//
//  Created by Matheus Lenke on 23/05/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Testando uma View em Swift"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Abrir outra calculadora", for: .normal)
        button.addTarget(self, action: #selector(goToCalculator), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Details"

        view.backgroundColor = .systemBackground
        configUI()
    }
    
    private func configUI() {
        view.addSubview(titleLabel)
        
        view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            backButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            backButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    @objc func goToCalculator() {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CalculatorView") as? ViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}
