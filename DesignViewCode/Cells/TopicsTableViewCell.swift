//
//  TopicsTableViewCell.swift
//  DesignViewCode
//
//  Created by Joao Matheus on 26/12/23.
//

import UIKit

final class TopicsTableViewCell: UITableViewCell {
    static let identifier = "TopicsTableViewCell"

    private lazy var logoBackgroundView: CustomView = {
        let element = CustomView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = .setRGBColor(red: 255, green: 255, blue: 255, opacity: 0.4)
        element.cornerRadius = 18
        element.shadowOpacity = 0.5
        element.shadowOffset = 5
        element.shadowColor = .colorShadow
        element.shadowRadius = 10
        element.layer.masksToBounds = false
        return element
    }()
    
    private lazy var logoImage: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.alpha = 0.7
        element.tintColor = UIColor(named: "AccentColor 1")
        return element
    }()
    
    private lazy var nameLabel: UILabel = {
        let element = UILabel()
        element.adjustsFontSizeToFitWidth = true
        element.translatesAutoresizingMaskIntoConstraints = false
        element.numberOfLines = 0
        element.font = UIFont.boldSystemFont(ofSize: 17)
        return element
        
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        super.layoutIfNeeded()
        backgroundColor = .clear
        setUpConstraints()
    }

    func configure(topic: Topic) {
        nameLabel.text = topic.topicName
        logoImage.image = UIImage(systemName: topic.topicSymbol)
    }

    private func setUpConstraints() {
        contentView.addSubview(logoBackgroundView)
        contentView.addSubview(nameLabel)
        logoBackgroundView.addSubview(logoImage)
        
        NSLayoutConstraint.activate([
            logoBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            logoBackgroundView.heightAnchor.constraint(equalToConstant: 36),
            logoBackgroundView.widthAnchor.constraint(equalToConstant: 36),
            logoBackgroundView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: logoBackgroundView.topAnchor, constant: 8),
            logoImage.leadingAnchor.constraint(equalTo: logoBackgroundView.leadingAnchor, constant: 8),
            logoImage.trailingAnchor.constraint(equalTo: logoBackgroundView.trailingAnchor, constant: -8),
            logoImage.bottomAnchor.constraint(equalTo: logoBackgroundView.bottomAnchor, constant: -8)
        ])
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: logoBackgroundView.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
