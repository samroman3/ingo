//
//  ViewController.swift
//  ingo-proto
//
//  Created by Sam Roman on 11/12/19.
//  Copyright © 2019 Sam Roman. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    //MARK: UI Objects
    
    var loginOffset = 0
    
    lazy var logoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        //        label.font = UIFont(name: "Trebuchet MS", size: 100)
        let attributedTitle = NSMutableAttributedString(string: "in", attributes: [NSAttributedString.Key.font: UIFont(name: "Trebuchet MS", size: 100)!, NSAttributedString.Key.foregroundColor: UIColor.systemPurple])
        attributedTitle.append(NSAttributedString(string: "go", attributes: [NSAttributedString.Key.font: UIFont(name: "Trebuchet MS", size: 134)!, NSAttributedString.Key.foregroundColor:  UIColor.systemPurple ]))
        //        label.textColor = .systemPurple
        label.attributedText = attributedTitle
        label.backgroundColor = .clear
        label.textAlignment = .center
        return label
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " Enter Email..."
        textField.autocorrectionType = .no
        textField.textAlignment = .center
        textField.layer.cornerRadius = 15
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.addTarget(self, action: #selector(validateFields), for: .editingChanged)
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " Enter Password..."
        textField.autocorrectionType = .no
        textField.textAlignment = .center
        textField.isSecureTextEntry = true
        textField.layer.cornerRadius = 15
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.addTarget(self, action: #selector(validateFields), for: .editingChanged)
        return textField
    }()
    
    lazy var userNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " Enter Username..."
        textField.autocorrectionType = .no
        textField.textAlignment = .center
        textField.layer.cornerRadius = 15
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.addTarget(self, action: #selector(validateFields), for: .editingChanged)
        textField.alpha = 0.0
        textField.isEnabled = false
        return textField
    }()
    
    lazy var emailIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(systemName: "at", withConfiguration: .none)
        icon.tintColor = .lightGray
        icon.backgroundColor = .clear
        return icon
    }()
    
    lazy var passwordIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(systemName: "lock.circle", withConfiguration: .none)
        icon.tintColor = .lightGray
        icon.backgroundColor = .clear
        return icon
    }()
    
    lazy var userNameIcon: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(systemName: "person.circle", withConfiguration: .none)
        icon.tintColor = .lightGray
        icon.backgroundColor = .clear
        icon.alpha = 0
        return icon
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = button.titleLabel?.font.withSize(34)
        button.backgroundColor = .systemPurple
        button.addTarget(self, action: #selector(tryLogin), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = button.titleLabel?.font.withSize(34)
        button.backgroundColor = .systemPurple
        button.addTarget(self, action: #selector(trySignUp), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    lazy var createAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Dont have an account?  ", attributes: [NSAttributedString.Key.font: UIFont(name: "Verdana", size: 14)!, NSAttributedString.Key.foregroundColor: UIColor.white])
        attributedTitle.append(NSAttributedString(string: "Sign Up", attributes: [NSAttributedString.Key.font: UIFont(name: "Verdana-Bold", size: 14)!, NSAttributedString.Key.foregroundColor:  UIColor.systemPurple ]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(showSignUp), for: .touchUpInside)
        return button
    }()
    
    lazy var alreadyHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Already have an account?  ", attributes: [NSAttributedString.Key.font: UIFont(name: "Verdana", size: 14)!, NSAttributedString.Key.foregroundColor: UIColor.white])
        attributedTitle.append(NSAttributedString(string: "Login!", attributes: [NSAttributedString.Key.font: UIFont(name: "Verdana-Bold", size: 14)!, NSAttributedString.Key.foregroundColor:  UIColor.systemPurple ]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(showLogIn), for: .touchUpInside)
        button.isHidden = true
        button.isEnabled = false
        return button
    }()
    
    //MARK: Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.301, green: 0.33, blue: 0.36, alpha: 1)
        setupSubViews()
    }
    
    //MARK: Obj-C methods
    
    @objc func validateFields() {
        guard emailTextField.hasText, passwordTextField.hasText else {
            loginButton.isEnabled = false
            return
        }
        loginButton.isEnabled = true
        emailIcon.tintColor = .systemPurple
        passwordIcon.tintColor = .systemPurple
        userNameIcon.tintColor = .systemPurple
    }
    
    @objc func showSignUp() {
        
        loginButtonLeadingAnchor.constant = 415
        alreadyHaveAccountButton.isHidden = false
        alreadyHaveAccountButton.isEnabled = true
        createAccountButton.isHidden = true
        createAccountButton.isEnabled = false
        print(loginButtonLeadingAnchor.constant)
        UIView.animate(withDuration: 1, animations: {
            self.view.layoutIfNeeded()
        }) { (action) in
            UIView.animate(withDuration: 0.5) {
                self.usernameTopConstraint.constant = 60
                self.userNameTextField.alpha = 1
                self.userNameTextField.isEnabled = true
                self.userNameIcon.alpha = 1
                self.view.layoutIfNeeded()
            }
            self.signUpButton.isEnabled = true
            self.loginButton.isEnabled = false
        }
    }
    
    @objc func showLogIn() {
        let oldOffset = loginButtonLeadingAnchor.constant
        loginButtonLeadingAnchor.constant = oldOffset - 415
        createAccountButton.isHidden = false
        createAccountButton.isEnabled = true
        alreadyHaveAccountButton.isHidden = true
        alreadyHaveAccountButton.isEnabled = false
        print(loginButtonLeadingAnchor.constant)
        UIView.animate(withDuration: 1, animations: {
            self.view.layoutIfNeeded()
        }) { (action) in
            UIView.animate(withDuration: 0.5) {
                let userOffset = self.usernameTopConstraint.constant
                self.usernameTopConstraint.constant = userOffset - 60
                self.userNameTextField.alpha = 0.0
                self.userNameTextField.isEnabled = false
                self.userNameIcon.alpha = 0
                self.view.layoutIfNeeded()
            }
            self.signUpButton.isEnabled = false
            self.loginButton.isEnabled = true
        }
        
    }
    
    
    @objc func tryLogin() {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            showAlert(with: "Error", and: "Please fill out all fields.")
            return
        }
        
        guard email.isValidEmail else {
            showAlert(with: "Error", and: "Please enter a valid email")
            return
        }
        
        guard password.isValidPassword else {
            showAlert(with: "Error", and: "Please enter a valid password. Passwords must have at least 8 characters.")
            return
        }
        
        FirebaseAuthService.manager.loginUser(email: email.lowercased(), password: password) { (result) in
            self.handleLoginResponse(with: result)
        }
    }
    
    @objc func trySignUp() {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            showAlert(with: "Error", and: "Please fill out all fields.")
            return
        }
        
        guard email.isValidEmail else {
            showAlert(with: "Error", and: "Please enter a valid email")
            return
        }
        
        guard password.isValidPassword else {
            showAlert(with: "Error", and: "Please enter a valid password. Passwords must have at least 8 characters.")
            return
        }
        
        guard userNameTextField.hasText else {
            showAlert(with: "Error", and: "Please enter a valid user name.")
            return
        }
        
        FirebaseAuthService.manager.createNewUser(email: email.lowercased(), password: password) { [weak self] (result) in
            self?.handleCreateAccountResponse(with: result)
        }
    }
    
    //MARK: Private methods
    
    private func showAlert(with title: String, and message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    private func handleLoginResponse(with result: Result<User, Error>) {
        switch result {
        case .failure(let error):
            showAlert(with: "Error", and: "Could not log in. Error: \(error)")
        case .success:
                        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                            let sceneDelegate = windowScene.delegate as? SceneDelegate
                            else {
                                return
                        }
            print("login successful")
                        UIView.transition(with: self.view, duration: 0.1, options: .transitionFlipFromBottom, animations: {
                            sceneDelegate.window?.rootViewController = MainTabViewController()
                        }, completion: nil)
        }
    }
    
    private func handleCreateAccountResponse(with result: Result<User, Error>) {
        DispatchQueue.main.async {
            switch result {
            case .success(let user):
                //MARK: TODO: move this logic to the server
                FirestoreService.manager.createAppUser(user: AppUser(from: user)) { [weak self] newResult in
                    FirebaseAuthService.manager.updateUserNameField(username: self?.userNameTextField.text ?? "") { (result) in
                        self?.handleCreatedUserInFirestore(result: result)
                    }
                }
            case .failure(let error):
                self.showAlert(with: "Error creating user", and: "An error occured while creating new account \(error)")
            }
        }
    }
    
    private func handleCreatedUserInFirestore(result: Result<Void, Error>) {
        switch result {
        case .success:
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                let sceneDelegate = windowScene.delegate as? SceneDelegate
                else {
                    self.dismiss(animated: true, completion: nil)
                    return
            }
            print("sign up successful!")
            
                        UIView.transition(with: self.view, duration: 0.1, options: .transitionFlipFromBottom, animations: {
                            sceneDelegate.window?.rootViewController = MainTabViewController()
                    }, completion: nil)
        case .failure(let error):
            self.showAlert(with: "Error creating user", and: "An error occured while creating new account \(error)")
        }
    }
    
    //MARK: UI Setup
    
    private func setupSubViews() {
        setupLogoLabel()
        setupCreateAccountButton()
        setupLoginStackView()
        setupUsernameField()
        setupEmailIcon()
        setupPasswordIcon()
        setupUserNameIcon()
        setUpLoginButton()
        setUpSignUpButton()
        setupHaveAccountButton()
    }
    
    private func setupLogoLabel() {
        view.addSubview(logoLabel)
        
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([logoLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 60), logoLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16), logoLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16)])
    }
    
    private func setupLoginStackView() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField])
        stackView.axis = .vertical
        stackView.spacing = 15
        stackView.distribution = .fillEqually
        self.view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([stackView.bottomAnchor.constraint(equalTo: createAccountButton.topAnchor, constant: -350),
                                     stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
                                     stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
                                     stackView.heightAnchor.constraint(equalToConstant: 100)])
    }
    
    private func setupUsernameField(){
        view.addSubview(userNameTextField)
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            usernameTopConstraint,
            userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            userNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            userNameTextField.heightAnchor.constraint(equalTo: passwordTextField.heightAnchor)
        ])
    }
    
    lazy var usernameTopConstraint: NSLayoutConstraint = {
        userNameTextField.topAnchor.constraint(equalTo: passwordTextField.topAnchor, constant:  0)
    }()
    
    
    private func setupEmailIcon(){
        view.addSubview(emailIcon)
        emailIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailIcon.trailingAnchor.constraint(equalTo: emailTextField.leadingAnchor, constant: -10),
            emailIcon.centerYAnchor.constraint(equalTo: emailTextField.centerYAnchor),
            emailIcon.heightAnchor.constraint(equalToConstant: 30),
            emailIcon.widthAnchor.constraint(equalToConstant: 30)])
    }
    
    private func setupPasswordIcon(){
        view.addSubview(passwordIcon)
        passwordIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordIcon.trailingAnchor.constraint(equalTo: passwordTextField.leadingAnchor, constant: -10),
            passwordIcon.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor),
            passwordIcon.heightAnchor.constraint(equalToConstant: 30),
            passwordIcon.widthAnchor.constraint(equalToConstant: 30)])
    }
    
    private func setupUserNameIcon(){
        view.addSubview(userNameIcon)
        userNameIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userNameIcon.trailingAnchor.constraint(equalTo: userNameTextField.leadingAnchor, constant: -10),
            userNameIcon.centerYAnchor.constraint(equalTo: userNameTextField.centerYAnchor),
            userNameIcon.heightAnchor.constraint(equalToConstant: 30),
            userNameIcon.widthAnchor.constraint(equalToConstant: 30)])
    }
    
    private func setUpLoginButton(){
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 30), loginButton.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 70),
            loginButtonLeadingAnchor])
        view.layoutIfNeeded()
        
    }
    
    lazy var loginButtonLeadingAnchor: NSLayoutConstraint = {
        loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor)
    }()
    
    private func setUpSignUpButton(){
        view.addSubview(signUpButton)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            signUpButton.centerYAnchor.constraint(equalTo: loginButton.centerYAnchor), signUpButton.widthAnchor.constraint(equalTo: loginButton.widthAnchor),
            signUpButton.trailingAnchor.constraint(equalTo: loginButton.leadingAnchor),
            signUpButton.heightAnchor.constraint(equalToConstant: 70)])
    }
    
    
    
    
    
    
    private func setupCreateAccountButton() {
        view.addSubview(createAccountButton)
        
        createAccountButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([createAccountButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     createAccountButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     createAccountButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                                     createAccountButton.heightAnchor.constraint(equalToConstant: 50)])
    }
    
    private func setupHaveAccountButton() {
        view.addSubview(alreadyHaveAccountButton)
        
        alreadyHaveAccountButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([alreadyHaveAccountButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     alreadyHaveAccountButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                                     alreadyHaveAccountButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                                     alreadyHaveAccountButton.heightAnchor.constraint(equalToConstant: 50)])
    }
}
