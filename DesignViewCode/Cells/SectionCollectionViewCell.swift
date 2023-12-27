//
//  SectionCollectionViewCell.swift
//  DesignViewCode
//
//  Created by Joao Matheus on 15/12/23.
//

import UIKit

final class SectionCollectionViewCell: UICollectionViewCell {
    static let identifier = "SectionCollectionViewCell"

    private lazy var backgroundVisualEffect: CustomBlurView = {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        let element = CustomBlurView(effect: blurEffect)
        element.layer.cornerRadius = 30
        element.layer.masksToBounds = true
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    private lazy var bannerView: CustomView = {
        let element = CustomView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = .black
        element.alpha = 0.05
        element.cornerRadius = 20
        return element
    }()

    private lazy var bannerImage: CustomImageView = {
        let element = CustomImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.image = UIImage(named: "Avatar")
        element.cornerRadius = 20
        return element
    }()

    private lazy var logoImage: CustomImageView = {
        let element = CustomImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.image = UIImage(named: "Logo SwiftUI")
        element.backgroundColor = .setRGBColor(red: 24, green: 32, blue: 77, opacity: 1)
        element.cornerRadius = 10
        return element
    }()

    private lazy var playImage: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.image = UIImage(named: "Play")
        return element
    }()

    private lazy var infoVisualEffect: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect, style: .label)
        let element = UIVisualEffectView(effect: vibrancyEffect)
        element.layer.cornerRadius = 30
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    private lazy var titleLabel: UILabel = {
        let element = UILabel()
        element.adjustsFontSizeToFitWidth = true
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "UIKit for iOS 15"
        element.numberOfLines = 2
        element.font = UIFont.systemFont(ofSize: 11)
        return element
    }()

    private lazy var subtitleLabel: UILabel = {
        let element = UILabel()
        element.adjustsFontSizeToFitWidth = true
        element.adjustsFontSizeToFitWidth = true
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "UIKit for iOS 15"
        element.font = UIFont.boldSystemFont(ofSize: 15)
        element.numberOfLines = 0
        return element
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = 30
        contentView.backgroundColor = .clear
        layer.shadowColor = UIColor.colorShadow.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowRadius = 5
        layer.cornerRadius = 30
        setConstraints()
    }

    func configure(section: Section) {
        titleLabel.text = section.sectionTitle
        subtitleLabel.text = section.sectionSubtitle
        logoImage.image = section.sectionIcon
        bannerImage.image = section.sectionBanner
    }

    private func setConstraints() {
        contentView.addSubview(backgroundVisualEffect)
        backgroundVisualEffect.contentView.addSubview(bannerView)
        
        backgroundVisualEffect.contentView.addSubview(bannerImage)
        backgroundVisualEffect.contentView.addSubview(playImage)
        backgroundVisualEffect.contentView.addSubview(logoImage)
        backgroundVisualEffect.contentView.addSubview(infoVisualEffect)
        
        infoVisualEffect.contentView.addSubview(titleLabel)
        infoVisualEffect.contentView.addSubview(subtitleLabel)

        NSLayoutConstraint.activate([
            backgroundVisualEffect.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundVisualEffect.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundVisualEffect.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgroundVisualEffect.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            bannerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            bannerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            bannerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            bannerView.heightAnchor.constraint(equalToConstant: 90)
        ])
        NSLayoutConstraint.activate([
            bannerImage.topAnchor.constraint(equalTo: bannerView.topAnchor),
            bannerImage.leadingAnchor.constraint(equalTo: bannerView.leadingAnchor),
            bannerImage.trailingAnchor.constraint(equalTo: bannerView.trailingAnchor),
            bannerImage.bottomAnchor.constraint(equalTo: bannerView.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            playImage.widthAnchor.constraint(equalToConstant: 60),
            playImage.heightAnchor.constraint(equalToConstant: 60),
            playImage.centerYAnchor.constraint(equalTo: bannerImage.centerYAnchor),
            playImage.centerXAnchor.constraint(equalTo: bannerImage.centerXAnchor)
        ])
        NSLayoutConstraint.activate([
            logoImage.widthAnchor.constraint(equalToConstant: 26),
            logoImage.heightAnchor.constraint(equalToConstant: 26),
            logoImage.leadingAnchor.constraint(equalTo: bannerView.leadingAnchor),
            logoImage.bottomAnchor.constraint(equalTo: bannerView.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            infoVisualEffect.topAnchor.constraint(equalTo: bannerView.bottomAnchor),
            infoVisualEffect.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            infoVisualEffect.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            infoVisualEffect.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            infoVisualEffect.topAnchor.constraint(equalTo: bannerView.bottomAnchor),
            infoVisualEffect.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            infoVisualEffect.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            infoVisualEffect.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            subtitleLabel.leadingAnchor.constraint(equalTo: infoVisualEffect.leadingAnchor, constant: 16),
            subtitleLabel.trailingAnchor.constraint(equalTo: infoVisualEffect.trailingAnchor, constant: -16),
            subtitleLabel.bottomAnchor.constraint(equalTo: infoVisualEffect.bottomAnchor, constant: -8)
        ])
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: bannerView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: infoVisualEffect.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: infoVisualEffect.trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor, constant: 8)
        ])
    }
}
