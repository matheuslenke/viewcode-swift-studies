//
//  ChatScreen.swift
//  MessengerApp
//
//  Created by Matheus Lenke on 10/05/22.
//

import UIKit
import AVFoundation

protocol ChatScreenProtocol: AnyObject {
    func actionPushMessage()
}

class ChatScreen: UIView {
    
    weak private var delegate: ChatScreenProtocol?
    
    public func delegate(delegate: ChatScreenProtocol?) {
        self.delegate = delegate
    }
    
    var bottomConstraint: NSLayoutConstraint?
    var player: AVAudioPlayer?
    
    lazy var navView: ChatNavigationView = {
        let view = ChatNavigationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var messageInputView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var messageBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = CustomColor.appLight
        view.layer.cornerRadius = 20
        return view
    }()
    
    lazy var sendBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = CustomColor.appPink
        btn.layer.cornerRadius = 22.5
        btn.layer.shadowColor = CustomColor.appLight.cgColor
        btn.layer.shadowRadius = 10
        btn.layer.shadowOffset = CGSize(width: 0, height: 5)
        btn.layer.shadowOpacity = 0.3
        btn.addTarget(self, action: #selector(sendBtnPressed), for: .touchUpInside)
        btn.setImage(UIImage(named: "send"), for: .normal)
        return btn
    }()
    
    lazy var inputMessageTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Digite aqui"
        tf.delegate = self
        tf.font = UIFont(name: CustomFont.poppinsSemiBold, size: 14)
        tf.textColor = .darkGray
        return tf
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(IncomingTextMessageTableViewCell.self, forCellReuseIdentifier: IncomingTextMessageTableViewCell.identifier)
        table.register(OutgoingTextMessageTableViewCell.self, forCellReuseIdentifier: OutgoingTextMessageTableViewCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = .clear
        table.transform = CGAffineTransform(scaleX: 1, y: 1)
        table.separatorStyle = .none
        table.tableFooterView = UIView()
        return table
    }()
    
    // MARK: Table view methods
    
    public func configTableView(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        self.tableView.delegate = delegate
        self.tableView.dataSource = dataSource
    }
    
    public func reloadTableView() {
        self.tableView.reloadData()
    }
    
    public func configNavView(controller: ChatViewController) {
        self.navView.controller = controller
    }
    
    // MARK: Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addElements()
        setupConstraints()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleKeyboardNotification(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleKeyboardNotification(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.inputMessageTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)) , for: UIControl.Event.editingChanged)
        
        self.bottomConstraint = NSLayoutConstraint(item: self.messageInputView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        
        if let bottomConstraint = bottomConstraint {
            self.addConstraint(bottomConstraint)
        }
        
        self.sendBtn.isEnabled = false
        self.sendBtn.layer.opacity = 0.4
        self.sendBtn.transform = .init(scaleX: 0.8, y: 0.8)
        self.inputMessageTextField.becomeFirstResponder()
    }
    
    // MARK: Private functions
    
    private func addElements() {
        self.addSubview(self.tableView)
        self.addSubview(self.navView)
        self.addSubview(messageInputView)
        self.messageInputView.addSubview(self.messageBar)
        self.messageBar.addSubview(self.sendBtn)
        self.messageBar.addSubview(self.inputMessageTextField)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            self.navView.topAnchor.constraint(equalTo: self.topAnchor),
            self.navView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.navView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.navView.heightAnchor.constraint(equalToConstant: 140),
            
            self.tableView.topAnchor.constraint(equalTo: self.navView.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.messageInputView.topAnchor),
            
            self.messageInputView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            self.messageInputView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.messageInputView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.messageInputView.heightAnchor.constraint(equalToConstant: 80),
            
            self.messageBar.leadingAnchor.constraint(equalTo: self.messageInputView.leadingAnchor,constant: 20),
            self.messageBar.trailingAnchor.constraint(equalTo: self.messageInputView.trailingAnchor,constant: -20),
            self.messageBar.heightAnchor.constraint(equalToConstant: 55),
            self.messageBar.centerYAnchor.constraint(equalTo: self.messageInputView.centerYAnchor),
            
            self.sendBtn.trailingAnchor.constraint(equalTo: self.messageBar.trailingAnchor, constant: -15),
            self.sendBtn.heightAnchor.constraint(equalToConstant: 55),
            self.sendBtn.widthAnchor.constraint(equalToConstant: 55),
            self.sendBtn.bottomAnchor.constraint(equalTo: self.messageBar.bottomAnchor, constant: -10),
            
            self.inputMessageTextField.leadingAnchor.constraint(equalTo: self.messageBar.leadingAnchor,constant: 20),
            self.inputMessageTextField.trailingAnchor.constraint(equalTo: self.sendBtn.leadingAnchor,constant: -5),
            self.inputMessageTextField.heightAnchor.constraint(equalToConstant: 45),
            self.inputMessageTextField.centerYAnchor.constraint(equalTo: self.messageBar.centerYAnchor)
        ])
    }
    

    
    // MARK: KeyboardObserver
    
    @objc func handleKeyboardNotification(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            
            self.bottomConstraint?.constant = isKeyboardShowing ? -keyboardHeight : 0
            
            self.tableView.center.y = isKeyboardShowing ? self.tableView.center.y - keyboardHeight : self.tableView.center.y + keyboardHeight
            
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut) {
                self.layoutIfNeeded()
            } completion: { (completed) in
                // Config!
            }

        }
    }
    
    // MARK: Button targets
    
    @objc func sendBtnPressed() {
        self.sendBtn.touchAnimation(s: self.sendBtn)
        self.playSound()
        self.delegate?.actionPushMessage()
        self.startPushMessage()
    }
    
    public func startPushMessage() {
        self.inputMessageTextField.text = ""
        self.sendBtn.isEnabled = false
        self.sendBtn.layer.opacity = 0.4
        self.sendBtn.transform = .init(scaleX: 0.8, y: 0.8)
    }
    
    public func playSound() {
        guard let url = Bundle.main.url(forResource: "send", withExtension: "wav") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            self.player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
            guard let player = self.player else { return }
            player.play()
        } catch(let error) {
            print(error.localizedDescription)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ChatScreen: UITextFieldDelegate {
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if self.inputMessageTextField.text == "" {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.sendBtn.isEnabled = false
                self.sendBtn.layer.opacity = 0.4
                self.sendBtn.transform = .init(scaleX: 0.8, y: 0.8)
            } completion: { _ in
            }

        } else {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.sendBtn.isEnabled = true
                self.sendBtn.layer.opacity = 1
                self.sendBtn.transform = .identity
            } completion: { _ in
            }
        }
    }
    
}
