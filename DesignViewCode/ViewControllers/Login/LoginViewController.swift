//
//  LoginViewController.swift
//  DesignViewCode
//
//  Created by Joao Matheus on 19/12/23.
//

import UIKit
import FirebaseAuth
import Combine

final class LoginViewController: UIViewController {
    
    enum LoginStatus {
        case signUp
        case signIn
    }
    
    private lazy var backgroundImageView: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.image = UIImage(named: "Background 6")
        return element
    }()
    
    private lazy var mainView: CustomView = {
        let element = CustomView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.alpha = 0
        element.cornerRadius = 30
        element.shadowOpacity = 0.15
        element.shadowOffset = 30
        element.shadowColor = .colorShadow
        element.shadowRadius = 30
        element.borderWidth = 0.5
        element.borderColor = .quaternaryLabel
        element.backgroundColor = UIColor(named: "BlurBackground")
        return element
    }()

    private lazy var mainVisualEffect: CustomBlurView = {
        let blurEffect = UIBlurEffect(style: .regular)
        let element = CustomBlurView(effect: blurEffect)
        element.cornerRadius = 30
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var mainVisualEffectBlur: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .prominent)
        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect, style: .label)
        let element = UIVisualEffectView(effect: vibrancyEffect)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    private lazy var titleLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "Sign up"
        element.adjustsFontForContentSizeCategory = true
        element.maximumContentSizeCategory = .accessibilityExtraLarge
        element.font = .boldSystemFont(ofSize: 34)
        element.numberOfLines = 1
        return element
    }()

    private lazy var subtitleLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "Access 120+ hours of coureses, tutorials and livestreams"
        element.adjustsFontForContentSizeCategory = true
        element.maximumContentSizeCategory = .accessibilityExtraLarge
        element.font = .systemFont(ofSize: 17)
        element.alpha = 0.7
        element.numberOfLines = 0
        return element
    }()

    private lazy var emailView: CustomView = {
        let element = CustomView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.cornerRadius = 20
        element.shadowOpacity = 0.5
        element.shadowOffset = 30
        element.shadowColor = .colorShadow
        element.shadowRadius = 30
        element.backgroundColor = .setRGBColor(red: 255, green: 255, blue: 255, opacity: 0.4)
        return element
    }()
    
    private lazy var iconEmailView: CustomView = {
        let element = CustomView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.cornerRadius = 14
        element.borderColor = .setRGBColor(red: 255, green: 255, blue: 255, opacity: 0.6)
        element.backgroundColor = .setRGBColor(red: 255, green: 255, blue: 255, opacity: 0.4)
        return element
    }()
    
    private lazy var iconEmailImageView: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.image = UIImage(systemName: "envelope.open.fill")
        element.tintColor = UIColor(named: "AccentColor 1")
        element.preferredSymbolConfiguration = .init(weight: .semibold)
        return element
    }()
    
    private lazy var emailTextField: UITextField = {
        let element = UITextField()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.borderStyle = .none
        element.placeholder = "Email Address"
        element.font = .systemFont(ofSize: 17)
        element.textContentType = .emailAddress
        element.autocapitalizationType = .none
        element.textColor = .setRGBColor(red: 0, green: 0, blue: 0, opacity: 0.6)
        return element
    }()
    
    private lazy var passwordView: CustomView = {
        let element = CustomView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.cornerRadius = 20
        element.shadowOpacity = 0.5
        element.shadowOffset = 30
        element.shadowColor = .colorShadow
        element.shadowRadius = 30
        element.backgroundColor = .setRGBColor(red: 255, green: 255, blue: 255, opacity: 0.4)
        return element
    }()
    
    private lazy var iconPasswordView: CustomView = {
        let element = CustomView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.cornerRadius = 14
        element.borderColor = .setRGBColor(red: 255, green: 255, blue: 255, opacity: 0.6)
        element.backgroundColor = .setRGBColor(red: 255, green: 255, blue: 255, opacity: 0.4)
        return element
    }()
    
    private lazy var iconPasswordImageView: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.image = UIImage(systemName: "key.fill")
        element.tintColor = UIColor(named: "AccentColor 1")
        element.preferredSymbolConfiguration = .init(weight: .semibold)
        return element
    }()
    
    private lazy var passwordTextField: UITextField = {
        let element = UITextField()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.borderStyle = .none
        element.font = .systemFont(ofSize: 17)
        element.placeholder = "Password"
        element.textContentType = .password
        element.autocapitalizationType = .none
        element.isSecureTextEntry = true
        element.textColor = .setRGBColor(red: 0, green: 0, blue: 0, opacity: 0.6)
        return element
    }()
    
    private lazy var createAccountView: CustomView = {
        let element = CustomView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.cornerRadius = 20
        element.shadowOpacity = 0.5
        element.shadowOffset = 30
        element.shadowColor = .colorShadow
        element.shadowRadius = 30
        element.backgroundColor = .setRGBColor(red: 255, green: 255, blue: 255, opacity: 0.4)
        element.clipsToBounds = true
        return element
    }()

    private lazy var createAccountButton: UIButton = {
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.setTitle("Create account", for: .normal)
        element.setTitleColor(.black, for: .normal)
        element.titleLabel?.font = .boldSystemFont(ofSize: 17)
        element.backgroundColor = .setRGBColor(red: 255, green: 255, blue: 255, opacity: 0.6)
        element.tintColor = .setRGBColor(red: 0, green: 0, blue: 0, opacity: 0.6)
        element.addAction(
            UIAction(handler: { [weak self] _ in
                guard let self else { return }
                if emailIsEmpty || passwordIsEmpty {
                    let alert = UIAlertController(
                        title: "Missing Information",
                        message: "Please make sure to enter a valid email and a password",
                        preferredStyle: .alert
                    )
                    alert.addAction(UIAlertAction(title: "OK", style: .default))
                    present(alert, animated: true)
                    return
                }
                if loginStatus == .signUp {
                    Auth.auth().createUser(
                        withEmail: emailTextField.text!,
                        password: passwordTextField.text!
                    ) { [weak self] result, error in
                        guard error == nil else {
                            print(error!.localizedDescription)
                            return
                        }
                        self?.goToHomeScreen()
                    }
                    return
                }
                Auth.auth().signIn(
                    withEmail: emailTextField.text!,
                    password: passwordTextField.text!
                ) { [weak self] result, error in
                    guard error == nil else {
                        print(error!.localizedDescription)
                        return
                    }
                    self?.goToHomeScreen()
                }
            }),
            for: .touchUpInside)
        return element
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "By clicking on Sign up, you agree to our Terms of service and Privacy policy."
        element.adjustsFontForContentSizeCategory = true
        element.maximumContentSizeCategory = .accessibilityExtraLarge
        element.font = .systemFont(ofSize: 13)
        element.numberOfLines = 0
        return element
    }()
    
    private lazy var separatorView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = .setRGBColor(red: 0, green: 0, blue: 0, opacity: 0.4)
        element.alpha = 0.1
        element.backgroundColor = .label
        return element
    }()
    
    private lazy var signUpButton: UIButton = {
        var config = UIButton.Configuration.plain()
        let attributedString = NSMutableAttributedString(string: "Sign in", attributes: [
            .font: UIFont.boldSystemFont(ofSize: 13),
            .foregroundColor: UIColor.label
        ])
        config.attributedSubtitle = AttributedString(attributedString)
        config.titleAlignment = .center
        let element = UIButton(type: .system)
        element.configuration = config
        element.translatesAutoresizingMaskIntoConstraints = false
        element.setTitle("Alreay have an account?", for: .normal)
        element.addAction(
            UIAction(handler: { [weak self] _ in
                self?.loginStatus = self?.loginStatus == .signUp ? .signIn : .signUp
            }),
            for: .touchUpInside)
        element.titleLabel?.font = .systemFont(ofSize: 13)
        element.setTitleColor(.label, for: .normal)
        return element
    }()
    
    var emailIsEmpty = true
    var passwordIsEmpty = true
    var loginStatus: LoginStatus = .signUp {
        didSet {
            titleLabel.text = loginStatus == .signUp ? "Sign Up" : "Sign in"
            createAccountButton.setTitle(loginStatus == .signUp ? "Create account" : "Sign in", for: .normal)
            signUpButton.setTitle(loginStatus == .signUp ? "Don't have an account?" : "Already have an account?", for: .normal)
            passwordTextField.textContentType = loginStatus == .signUp ? .newPassword : .password
        }
    }
    private var tokens: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
        
        UIView.animate(withDuration: 1.0, delay: 0.5, options: .curveEaseInOut) {
            self.mainView.alpha = 1
            self.mainView.frame = self.mainView.frame.offsetBy(dx: 0, dy: -400)
        }
        
        emailTextField.publisher(for: \.text).sink { [weak self] newValue in
            self?.emailIsEmpty = (newValue == "" || newValue == nil)
        }.store(in: &tokens)
        passwordTextField.publisher(for: \.text).sink { [weak self] newValue in
            self?.passwordIsEmpty = (newValue == "" || newValue == nil)
        }.store(in: &tokens)
    }

    private func setConstraints() {
        view.addSubview(backgroundImageView)
        view.addSubview(mainView)
        mainView.addSubview(mainVisualEffect)
        mainVisualEffect.contentView.addSubview(mainVisualEffectBlur)
        mainVisualEffectBlur.contentView.addSubview(titleLabel)
        mainVisualEffect.contentView.addSubview(subtitleLabel)
        mainVisualEffect.contentView.addSubview(emailView)
        emailView.addSubview(iconEmailView)
        iconEmailView.addSubview(iconEmailImageView)
        emailView.addSubview(emailTextField)
        mainVisualEffect.contentView.addSubview(passwordView)
        passwordView.addSubview(iconPasswordView)
        iconPasswordView.addSubview(iconPasswordImageView)
        passwordView.addSubview(passwordTextField)
        mainVisualEffect.contentView.addSubview(createAccountView)
        createAccountView.addSubview(createAccountButton)
        mainVisualEffect.contentView.addSubview(descriptionLabel)
        mainVisualEffect.contentView.addSubview(separatorView)
        mainVisualEffect.contentView.addSubview(signUpButton)
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mainView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            mainVisualEffect.topAnchor.constraint(equalTo: mainView.topAnchor),
            mainVisualEffect.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            mainVisualEffect.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            mainVisualEffect.bottomAnchor.constraint(equalTo: mainView.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            mainVisualEffectBlur.topAnchor.constraint(equalTo: mainVisualEffect.topAnchor),
            mainVisualEffectBlur.leadingAnchor.constraint(equalTo: mainVisualEffect.leadingAnchor),
            mainVisualEffectBlur.trailingAnchor.constraint(equalTo: mainVisualEffect.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: mainVisualEffectBlur.topAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: mainVisualEffectBlur.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: mainVisualEffectBlur.trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: mainVisualEffectBlur.bottomAnchor, constant: 0)
        ])
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            subtitleLabel.leadingAnchor.constraint(equalTo: mainVisualEffect.leadingAnchor, constant: 16),
            subtitleLabel.trailingAnchor.constraint(equalTo: mainVisualEffect.trailingAnchor, constant: -16),
        ])
        NSLayoutConstraint.activate([
            emailView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 20),
            emailView.leadingAnchor.constraint(equalTo: mainVisualEffect.leadingAnchor, constant: 16),
            emailView.trailingAnchor.constraint(equalTo: mainVisualEffect.trailingAnchor, constant: -16),
            emailView.heightAnchor.constraint(equalToConstant: 52)
        ])
        NSLayoutConstraint.activate([
            iconEmailView.leadingAnchor.constraint(equalTo: emailView.leadingAnchor, constant: 8),
            iconEmailView.centerYAnchor.constraint(equalTo: emailView.centerYAnchor),
            iconEmailView.heightAnchor.constraint(equalToConstant: 36),
            iconEmailView.widthAnchor.constraint(equalToConstant: 36)
        ])
        NSLayoutConstraint.activate([
            iconEmailImageView.centerXAnchor.constraint(equalTo: iconEmailView.centerXAnchor),
            iconEmailImageView.centerYAnchor.constraint(equalTo: iconEmailView.centerYAnchor),
        ])
        NSLayoutConstraint.activate([
            emailTextField.leadingAnchor.constraint(equalTo: iconEmailView.trailingAnchor, constant: 8),
            emailTextField.trailingAnchor.constraint(equalTo: emailView.trailingAnchor, constant: -8),
            emailTextField.centerYAnchor.constraint(equalTo: emailView.centerYAnchor),
        ])
        NSLayoutConstraint.activate([
            passwordView.topAnchor.constraint(equalTo: emailView.bottomAnchor, constant: 20),
            passwordView.leadingAnchor.constraint(equalTo: mainVisualEffect.leadingAnchor, constant: 16),
            passwordView.trailingAnchor.constraint(equalTo: mainVisualEffect.trailingAnchor, constant: -16),
            passwordView.heightAnchor.constraint(equalToConstant: 52)
        ])
        NSLayoutConstraint.activate([
            iconPasswordView.leadingAnchor.constraint(equalTo: passwordView.leadingAnchor, constant: 8),
            iconPasswordView.centerYAnchor.constraint(equalTo: passwordView.centerYAnchor),
            iconPasswordView.heightAnchor.constraint(equalToConstant: 36),
            iconPasswordView.widthAnchor.constraint(equalToConstant: 36)
        ])
        NSLayoutConstraint.activate([
            iconPasswordImageView.centerXAnchor.constraint(equalTo: iconPasswordView.centerXAnchor),
            iconPasswordImageView.centerYAnchor.constraint(equalTo: iconPasswordView.centerYAnchor),
        ])
        NSLayoutConstraint.activate([
            passwordTextField.leadingAnchor.constraint(equalTo: iconPasswordView.trailingAnchor, constant: 8),
            passwordTextField.trailingAnchor.constraint(equalTo: passwordView.trailingAnchor, constant: -8),
            passwordTextField.centerYAnchor.constraint(equalTo: passwordView.centerYAnchor),
        ])
        NSLayoutConstraint.activate([
            createAccountView.topAnchor.constraint(equalTo: passwordView.bottomAnchor, constant: 20),
            createAccountView.leadingAnchor.constraint(equalTo: mainVisualEffect.leadingAnchor, constant: 16),
            createAccountView.trailingAnchor.constraint(equalTo: mainVisualEffect.trailingAnchor, constant: -16),
            createAccountView.heightAnchor.constraint(equalToConstant: 52)
        ])
        NSLayoutConstraint.activate([
            createAccountButton.topAnchor.constraint(equalTo: createAccountView.topAnchor),
            createAccountButton.leadingAnchor.constraint(equalTo: createAccountView.leadingAnchor),
            createAccountButton.trailingAnchor.constraint(equalTo: createAccountView.trailingAnchor),
            createAccountButton.bottomAnchor.constraint(equalTo: createAccountView.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: createAccountView.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: mainVisualEffect.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: mainVisualEffect.trailingAnchor, constant: -16),
        ])
        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            separatorView.leadingAnchor.constraint(equalTo: mainVisualEffect.leadingAnchor, constant: 16),
            separatorView.trailingAnchor.constraint(equalTo: mainVisualEffect.trailingAnchor, constant: -16),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
        NSLayoutConstraint.activate([
            signUpButton.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 20),
            signUpButton.leadingAnchor.constraint(equalTo: mainVisualEffect.leadingAnchor, constant: 16),
            signUpButton.trailingAnchor.constraint(equalTo: mainVisualEffect.trailingAnchor, constant: -16),
            signUpButton.bottomAnchor.constraint(equalTo: mainVisualEffect.bottomAnchor, constant: -30)
        ])
    }
    
    private func goToHomeScreen() {
        let viewController = MainTabBarViewController()
        viewController.modalTransitionStyle = .flipHorizontal
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }
}
