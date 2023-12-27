//
//  CoursesTableViewCell.swift
//  DesignViewCode
//
//  Created by Joao Matheus on 27/12/23.
//

import UIKit

final class CoursesProgressTableViewCell: UITableViewCell {
    static let identifier = "CoursesProgressTableViewCell"
    
    private lazy var logoCourse: CustomView = {
        let element = CustomView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.cornerRadius = 30
        element.shadowOpacity = 0.3
        element.shadowOffset = 10
        element.shadowColor = UIColor(named: "Shadow")!
        element.shadowRadius = 20
        element.borderWidth = 1
        element.borderColor = .white
        return element
    }()

    private lazy var courseImage: CustomImageView = {
        let element = CustomImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.image = UIImage(named: "Logo SwiftUI")
        element.cornerRadius = 18
        element.backgroundColor = UIColor.setRGBColor(red: 24, green: 32, blue: 77, opacity: 1)
        return element
    }()

    private lazy var titleLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "UIKit for iOS 15"
        element.numberOfLines = 2
        element.font = UIFont.boldSystemFont(ofSize: 17)
        return element
    }()

    private lazy var subtitleLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "UIKit for iOS 15"
        element.font = UIFont.systemFont(ofSize: 12)
        element.numberOfLines = 0
        return element
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "DESCRIPTION LABEL"
        element.numberOfLines = 2
        element.font = UIFont.boldSystemFont(ofSize: 12)
        return element
    }()
    
    private lazy var progressView: UIProgressView = {
        let element = UIProgressView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.tintColor = .white
        element.progress = 35/100
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

    func configure(section: Section) {
        titleLabel.text = section.sectionTitle
        courseImage.image = section.sectionIcon
        descriptionLabel.text = section.sectionDescription
        subtitleLabel.text = section.sectionSubtitle
    }

    private func setUpConstraints() {
        contentView.addSubview(logoCourse)
        logoCourse.addSubview(courseImage)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(progressView)
        
        NSLayoutConstraint.activate([
            logoCourse.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            logoCourse.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            logoCourse.heightAnchor.constraint(equalToConstant: 62),
            logoCourse.widthAnchor.constraint(equalToConstant: 62)
        ])
        NSLayoutConstraint.activate([
            courseImage.centerXAnchor.constraint(equalTo: logoCourse.centerXAnchor),
            courseImage.centerYAnchor.constraint(equalTo: logoCourse.centerYAnchor),
            courseImage.heightAnchor.constraint(equalToConstant: 35),
            courseImage.widthAnchor.constraint(equalToConstant: 35)
        ])
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            subtitleLabel.leadingAnchor.constraint(equalTo: logoCourse.trailingAnchor, constant: 16),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: logoCourse.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: logoCourse.trailingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 12),
            progressView.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            progressView.widthAnchor.constraint(equalTo: descriptionLabel.widthAnchor, multiplier: 0.7)
        ])
    }
}
