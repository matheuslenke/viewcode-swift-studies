//
//  NavView.swift
//  MessengerApp
//
//  Created by Matheus Lenke on 06/05/22.
//

import UIKit

enum TypeConversationOrContact {
    case conversation
    case contact
}

protocol NavViewProtocol: AnyObject {
    func typeScreenMessage(type: TypeConversationOrContact)
}

class NavView: UIView {
    
    weak private var delegate: NavViewProtocol?
    
    func delegate(delegate: NavViewProtocol) {
        self.delegate = delegate
    }

    lazy var navBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 35
        view.layer.maskedCorners = [.layerMaxXMaxYCorner]
        view.layer.shadowColor = UIColor(white: 0, alpha: 0.02).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 10
        return view
    }()
    
    lazy var navBar: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var searchBar: UIView = {
        let view = UIView()
        view.backgroundColor = CustomColor.appLight
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var searchLabel: UILabel = {
        let label = UILabel()
        label.text = "Digite aqui"
        label.font = UIFont(name: CustomFont.poppinsMedium, size: 16)
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var searchBtn: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "search"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var conversationButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "message")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .systemPink
        button.addTarget(self, action: #selector(tappedConversationButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var contactButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "group")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(tappedContactButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    @objc func tappedConversationButton() {
        self.delegate?.typeScreenMessage(type: .conversation)
        self.conversationButton.tintColor = .systemPink
        self.contactButton.tintColor = .black
    }
    
    @objc func tappedContactButton() {
        self.delegate?.typeScreenMessage(type: .contact)
        self.conversationButton.tintColor = .black
        self.contactButton.tintColor = .systemPink
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addElements()
        self.setupConstraints()
    }
    
    private func addElements() {
        self.addSubview(self.navBackgroundView)
        self.navBackgroundView.addSubview(self.navBar)
        self.navBar.addSubview(self.searchBar)
        self.navBar.addSubview(self.stackView)
        self.stackView.addArrangedSubview(self.conversationButton)
        self.stackView.addArrangedSubview(self.contactButton)
        self.searchBar.addSubview(self.searchLabel)
        self.searchBar.addSubview(self.searchBtn)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.navBackgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.navBackgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.navBackgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            self.navBackgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.navBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.navBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.navBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.navBar.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.searchBar.leadingAnchor.constraint(equalTo: self.navBar.leadingAnchor, constant: 30),
            self.searchBar.centerYAnchor.constraint(equalTo: self.navBar.centerYAnchor),
            self.searchBar.trailingAnchor.constraint(equalTo: self.stackView.leadingAnchor, constant: -20),
            self.searchBar.heightAnchor.constraint(equalToConstant: 55),
            
            self.stackView.trailingAnchor.constraint(equalTo: self.navBar.trailingAnchor, constant: -30),
            self.stackView.centerYAnchor.constraint(equalTo: self.navBar.centerYAnchor),
            self.stackView.widthAnchor.constraint(equalToConstant: 100),
            self.stackView.heightAnchor.constraint(equalToConstant: 30),
            
            self.searchLabel.leadingAnchor.constraint(equalTo: self.searchBar.leadingAnchor, constant: 25),
            self.searchLabel.centerYAnchor.constraint(equalTo: self.searchBar.centerYAnchor),
            
            self.searchBtn.trailingAnchor.constraint(equalTo: self.searchBar.trailingAnchor, constant: -20),
            self.searchBtn.centerYAnchor.constraint(equalTo: self.searchBar.centerYAnchor),
            self.searchBtn.widthAnchor.constraint(equalToConstant: 20),
            self.searchBtn.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
