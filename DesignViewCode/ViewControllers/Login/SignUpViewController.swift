//
//  SignUpViewController.swift
//  DesignViewCode
//
//  Created by Joao Matheus on 19/12/23.
//

import UIKit

class SignUpViewController: UIViewController {
    
    private lazy var backgroundImageView: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.image = UIImage(named: "Background 6")
        return element
    }()
    
    private lazy var mainView: CustomView = {
        let element = CustomView()
        element.translatesAutoresizingMaskIntoConstraints = false
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConstraints()
    }
    
    private func setConstraints() {
        view.addSubview(backgroundImageView)
        view.addSubview(mainView)
        mainView.addSubview(mainVisualEffect)
        
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
            mainView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainView.heightAnchor.constraint(equalToConstant: 500)
        ])
        NSLayoutConstraint.activate([
            mainVisualEffect.topAnchor.constraint(equalTo: mainView.topAnchor),
            mainVisualEffect.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            mainVisualEffect.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            mainVisualEffect.bottomAnchor.constraint(equalTo: mainView.bottomAnchor)
        ])
    }
}
