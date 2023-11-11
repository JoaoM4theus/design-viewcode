//
//  HomeViewController.swift
//  DesignViewCode
//
//  Created by Joao Matheus on 10/11/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let element = UIScrollView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.contentInsetAdjustmentBehavior = .never
        return element
    }()

    private lazy var backgroundImage: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.image = UIImage(named: "Background01")
        element.contentMode = .bottomRight
        return element
    }()
    
    private lazy var cardView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = UIColor(named: "BlurBackground")
        return element
    }()
    
    private lazy var cardVisualEffect: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .regular)
        let element = UIVisualEffectView(effect: blurEffect)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var infoVisualEffect: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .regular)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
        let element = UIVisualEffectView(effect: vibrancyEffect)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var cardImageView: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.image = UIImage(named: "Illustration 2")
        return element
    }()
    
    private lazy var titleLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "UIKit for iOS 15"
        element.font = UIFont.boldSystemFont(ofSize: 28)
        return element
    }()
    
    private lazy var durationLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "20 SECTIONS - 3 HOURS"
        element.font = .systemFont(ofSize: 13, weight: .semibold)
        return element
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "Build an iOS app for iOS 15 with custom layouts, animations and more!"
        element.font = .systemFont(ofSize: 13, weight: .regular)
        element.numberOfLines = 2
        return element
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Featured"
        view.backgroundColor = UIColor(named: "PrimaryBackground")
        setUpConstraints()
    }

    private func setUpConstraints() {
        view.addSubview(scrollView)
        scrollView.addSubview(backgroundImage)
        scrollView.addSubview(cardView)
        cardView.addSubview(cardVisualEffect)
        cardView.addSubview(infoVisualEffect)
        cardVisualEffect.contentView.addSubview(cardImageView)
        infoVisualEffect.contentView.addSubview(titleLabel)
        infoVisualEffect.contentView.addSubview(durationLabel)
        infoVisualEffect.contentView.addSubview(descriptionLabel)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: scrollView.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            backgroundImage.widthAnchor.constraint(equalToConstant: view.frame.width)
        ])
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.topAnchor, constant: 20),
            cardView.heightAnchor.constraint(equalToConstant: 350),
            cardView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
        ])
        NSLayoutConstraint.activate([
            cardVisualEffect.topAnchor.constraint(equalTo: cardView.topAnchor),
            cardVisualEffect.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            cardVisualEffect.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            cardVisualEffect.bottomAnchor.constraint(equalTo: cardView.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            cardImageView.topAnchor.constraint(equalTo: cardVisualEffect.topAnchor),
            cardImageView.leadingAnchor.constraint(equalTo: cardVisualEffect.leadingAnchor),
            cardImageView.trailingAnchor.constraint(equalTo: cardVisualEffect.trailingAnchor),
        ])
        NSLayoutConstraint.activate([
            infoVisualEffect.topAnchor.constraint(equalTo: cardImageView.bottomAnchor),
            infoVisualEffect.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            infoVisualEffect.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            infoVisualEffect.bottomAnchor.constraint(equalTo: cardView.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: infoVisualEffect.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: infoVisualEffect.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: infoVisualEffect.trailingAnchor, constant: -20),
        ])
        NSLayoutConstraint.activate([
            durationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            durationLabel.leadingAnchor.constraint(equalTo: infoVisualEffect.leadingAnchor, constant: 20),
            durationLabel.trailingAnchor.constraint(equalTo: infoVisualEffect.trailingAnchor, constant: -20),
        ])
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: durationLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: infoVisualEffect.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: infoVisualEffect.trailingAnchor, constant: -20),
            descriptionLabel.bottomAnchor.constraint(greaterThanOrEqualTo: infoVisualEffect.bottomAnchor, constant: -16)
        ])
    }

}
