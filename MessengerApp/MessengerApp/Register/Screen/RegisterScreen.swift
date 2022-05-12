//
//  RegisterScreen.swift
//  LoginViewCode
//
//  Created by Matheus Lenke on 21/01/22.
//

import UIKit

protocol RegisterScreenProtocol: AnyObject {
    func actionBackButton()
    func actionRegisterButton()
}

class RegisterScreen: UIView {
    
    weak private var delegate: RegisterScreenProtocol?
    
    func delegate(_ delegate: RegisterScreenProtocol) {
        self.delegate = delegate
    }
    
    // MARK: UI Elements

    lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(tappedBackButton), for: .touchUpInside)
        return button
    }()
    
    lazy var imageAddUser: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "person.fill.badge.plus")
        image.tintColor = .white
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var nameTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocorrectionType = .no
        tf.backgroundColor = .white
        tf.borderStyle = .roundedRect
        tf.keyboardType = .emailAddress
        tf.placeholder = "Digite seu nome"
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.textColor = .darkGray
        
        return tf;
    }()
    
    lazy var emailTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocorrectionType = .no
        tf.backgroundColor = .white
        tf.borderStyle = .roundedRect
        tf.keyboardType = .emailAddress
        tf.autocapitalizationType = .none
        tf.placeholder = "Digite seu Email"
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.textColor = .darkGray
        
        return tf;
    }()
    
    lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocorrectionType = .no
        tf.backgroundColor = .white
        tf.borderStyle = .roundedRect
        tf.keyboardType = .default
        tf.isSecureTextEntry = true
        tf.placeholder = "Digite sua senha"
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.textColor = .darkGray
        
        return tf;
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Cadastrar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 7.5
        button.backgroundColor = UIColor(red: 3/255, green: 58/255, blue: 51/255, alpha: 1.0)
        button.addTarget(self, action: #selector(tappedRegisterButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: Life Cycle
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configBackground()
        self.configSuperView()
        self.setUpConstraints()
        configButtonEnable(false)
    }
    
    // MARK: Private Functions
    
    private func configSuperView() {
        self.addSubview(self.backButton)
        self.addSubview(self.imageAddUser)
        self.addSubview(self.nameTextField)
        self.addSubview(self.emailTextField)
        self.addSubview(self.passwordTextField)
        self.addSubview(self.registerButton)
    }
    
    private func configBackground() {
        self.backgroundColor = UIColor(red: 24/255, green: 117/255, blue: 104/255, alpha: 1.0)
    }
    
    private func configButtonEnable(_ enable: Bool) {
        if enable {
            self.registerButton.setTitleColor(.white, for: .normal)
            self.registerButton.isEnabled = true
            self.registerButton.backgroundColor = UIColor(red: 3/255, green: 58/255, blue: 51/255, alpha: 1.0)
        } else {
            self.registerButton.setTitleColor(.lightGray, for: .normal)
            self.registerButton.isEnabled = false
            self.registerButton.backgroundColor = .darkGray
        }
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            self.imageAddUser.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.imageAddUser.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            self.imageAddUser.widthAnchor.constraint(equalToConstant: 150),
            self.imageAddUser.heightAnchor.constraint(equalToConstant: 150),
            
            self.backButton.topAnchor.constraint(equalTo: self.imageAddUser.topAnchor),
            self.backButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            self.nameTextField.topAnchor.constraint(equalTo: self.imageAddUser.bottomAnchor, constant: 10),
            self.nameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.nameTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.nameTextField.heightAnchor.constraint(equalToConstant: 45),
            
            self.emailTextField.topAnchor.constraint(equalTo: self.nameTextField.bottomAnchor, constant: 15),
            self.emailTextField.leadingAnchor.constraint(equalTo: self.nameTextField.leadingAnchor),
            self.emailTextField.trailingAnchor.constraint(equalTo: self.nameTextField.trailingAnchor),
            self.emailTextField.heightAnchor.constraint(equalToConstant: 45),
            
            self.passwordTextField.topAnchor.constraint(equalTo: self.emailTextField.bottomAnchor, constant: 15),
            self.passwordTextField.leadingAnchor.constraint(equalTo: self.nameTextField.leadingAnchor),
            self.passwordTextField.trailingAnchor.constraint(equalTo: self.nameTextField.trailingAnchor),
            self.passwordTextField.heightAnchor.constraint(equalTo: self.nameTextField.heightAnchor),
            
            self.registerButton.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: 15),
            self.registerButton.leadingAnchor.constraint(equalTo: self.passwordTextField.leadingAnchor),
            self.registerButton.trailingAnchor.constraint(equalTo: self.passwordTextField.trailingAnchor),
            self.registerButton.heightAnchor.constraint(equalTo: self.passwordTextField.heightAnchor)
        ])
    }
    
    func configTextFieldDelegate(delegate: UITextFieldDelegate) {
        self.emailTextField.delegate = delegate
        self.passwordTextField.delegate = delegate
        self.nameTextField.delegate = delegate
    }
    
    
    // MARK: Public Functions
    
    public func validateTextFields() {
        guard let name: String = self.nameTextField.text else { return }
        guard let email: String = self.emailTextField.text else { return }
        guard let password: String = self.passwordTextField.text else { return }
        
        if !name.isEmpty && !email.isEmpty && !password.isEmpty {
            self.configButtonEnable(true)
        } else {
            self.configButtonEnable(false)
        }
    }
    
    public func getEmail() -> String {
        return self.emailTextField.text ?? ""
    }
    
    public func getPassword() -> String {
        return self.passwordTextField.text ?? ""
    }
    
    public func getName() -> String {
        return self.nameTextField.text ?? ""
    }
    
    // MARK: Buttons Actions
    
    @objc private func tappedBackButton() {
        self.delegate?.actionBackButton()
    }
    
    @objc private func tappedRegisterButton() {
        self.delegate?.actionRegisterButton()
    }
}
