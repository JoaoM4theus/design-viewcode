//
//  HandbooksCollectionViewCell.swift
//  DesignViewCode
//
//  Created by Joao Matheus on 30/11/23.
//

import UIKit

class HandbooksCollectionViewCell: UICollectionViewCell {
    static let identifier = "HandbooksCollectionViewCell"
    
    private lazy var mainView: CustomView = {
        let element = CustomView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = UIColor(named: "BlurBackground")
        element.cornerRadius = 30
        return element
    }()

    private lazy var viewBackground: CustomView = {
        let element = CustomView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = .systemIndigo
        element.cornerRadius = 30
        return element
    }()

    private lazy var visualEffect: CustomBlurView = {
        let blurEffect = UIBlurEffect(style: .systemThinMaterial)
        let element = CustomBlurView(effect: blurEffect)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.cornerRadius = 30
        return element
    }()

    private lazy var contentVisualEffect: CustomBlurView = {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        let element = CustomBlurView(effect: blurEffect)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.cornerRadius = 30
        return element
    }()

    private lazy var viewOpacity: CustomView = {
        let element = CustomView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.layer.opacity = 5/100
        element.cornerRadius = 30
        return element
    }()
    
    private lazy var imageHandbook: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.image = UIImage(named: "Illustration 2")
        return element
    }()
    
    private lazy var logoHandbook: CustomImageView = {
        let element = CustomImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.image = UIImage(named: "Logo SwiftUI")
        element.cornerRadius = 10
        element.backgroundColor = .setRGBColor(red: 24, green: 32, blue: 77, opacity: 1)
        return element
    }()
    
    private lazy var handbookDescription: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "Learn about all the basics of SwiftUI"
        element.font = .systemFont(ofSize: 12, weight: .regular)
        element.numberOfLines = 2
        return element
    }()
    
    private lazy var subtitle: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "20 HOURS - 30 SECTIONS"
        element.font = .systemFont(ofSize: 12, weight: .regular)
        element.numberOfLines = 0
        return element
    }()
    
    private lazy var title: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "SwiftUI Handbook"
        element.font = .systemFont(ofSize: 17, weight: .semibold)
        element.numberOfLines = 0
        return element
    }()
    
    private lazy var progressView: UIProgressView = {
        let element = UIProgressView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.tintColor = .white
        element.progress = 35/100
        return element
    }()

    let gradient = CAGradientLayer()
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        super.layoutIfNeeded()
        setUpConstraints()
        layer.shadowColor = UIColor(named: "Shadow")!.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowRadius = 30
        layer.masksToBounds = false
        layer.cornerRadius = 30
        layer.cornerCurve = .continuous
        
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.cornerCurve = .continuous
        gradient.cornerRadius = 30
        gradient.frame = CGRect(x: 0, y: 0, width: 160, height: 267)
        
        visualEffect.layer.insertSublayer(gradient, at: 0)
        visualEffect.layer.cornerRadius = 30
        visualEffect.layer.cornerCurve = .continuous
    }

    func configure(course: Course) {
        title.text = course.courseTitle
        subtitle.text = course.courserSubtitle
        handbookDescription.text = course.courseDescription
        gradient.colors = course.courseGradient
        imageHandbook.image = course.courseBanner
        logoHandbook.image = course.couserIcon
    }

    private func setUpConstraints() {
        contentView.addSubview(mainView)
        mainView.addSubview(viewBackground)
        mainView.addSubview(visualEffect)
        visualEffect.contentView.addSubview(contentVisualEffect)
        visualEffect.contentView.addSubview(viewOpacity)
        visualEffect.contentView.addSubview(progressView)
        visualEffect.contentView.addSubview(imageHandbook)
        visualEffect.contentView.addSubview(progressView)
        visualEffect.contentView.addSubview(logoHandbook)
        contentVisualEffect.contentView.addSubview(handbookDescription)
        contentVisualEffect.contentView.addSubview(subtitle)
        contentVisualEffect.contentView.addSubview(title)
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        NSLayoutConstraint.activate([
            viewBackground.topAnchor.constraint(equalTo: mainView.topAnchor),
            viewBackground.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            viewBackground.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            viewBackground.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
        ])
        NSLayoutConstraint.activate([
            visualEffect.topAnchor.constraint(equalTo: mainView.topAnchor),
            visualEffect.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            visualEffect.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            visualEffect.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
        ])
        NSLayoutConstraint.activate([
            viewOpacity.topAnchor.constraint(equalTo: visualEffect.topAnchor, constant: 16),
            viewOpacity.leadingAnchor.constraint(equalTo: visualEffect.leadingAnchor, constant: 16),
            viewOpacity.trailingAnchor.constraint(equalTo: visualEffect.trailingAnchor, constant: -16),
            viewOpacity.heightAnchor.constraint(equalToConstant: 90)
        ])
        NSLayoutConstraint.activate([
            imageHandbook.topAnchor.constraint(equalTo: viewOpacity.topAnchor),
            imageHandbook.leadingAnchor.constraint(equalTo: visualEffect.leadingAnchor),
            imageHandbook.trailingAnchor.constraint(equalTo: visualEffect.trailingAnchor),
            imageHandbook.bottomAnchor.constraint(equalTo: viewOpacity.bottomAnchor),
        ])
        NSLayoutConstraint.activate([
            progressView.leadingAnchor.constraint(equalTo: visualEffect.leadingAnchor, constant: 16),
            progressView.trailingAnchor.constraint(equalTo: visualEffect.trailingAnchor, constant: -16),
            progressView.bottomAnchor.constraint(greaterThanOrEqualTo: visualEffect.bottomAnchor, constant: -16),
        ])
        NSLayoutConstraint.activate([
            contentVisualEffect.topAnchor.constraint(equalTo: mainView.topAnchor),
            contentVisualEffect.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            contentVisualEffect.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            contentVisualEffect.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
        ])
        NSLayoutConstraint.activate([
            handbookDescription.leadingAnchor.constraint(equalTo: contentVisualEffect.leadingAnchor, constant: 16),
            handbookDescription.trailingAnchor.constraint(equalTo: contentVisualEffect.trailingAnchor, constant: -16),
            handbookDescription.bottomAnchor.constraint(equalTo: progressView.topAnchor, constant: -8),
        ])
        NSLayoutConstraint.activate([
            subtitle.leadingAnchor.constraint(equalTo: contentVisualEffect.leadingAnchor, constant: 16),
            subtitle.trailingAnchor.constraint(equalTo: contentVisualEffect.trailingAnchor, constant: -16),
            subtitle.bottomAnchor.constraint(equalTo: handbookDescription.topAnchor, constant: -8),
        ])
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: imageHandbook.bottomAnchor, constant: 16),
            title.leadingAnchor.constraint(equalTo: contentVisualEffect.leadingAnchor, constant: 16),
            title.trailingAnchor.constraint(equalTo: contentVisualEffect.trailingAnchor, constant: -16),
            title.bottomAnchor.constraint(equalTo: subtitle.topAnchor, constant: -8),
        ])
        NSLayoutConstraint.activate([
            logoHandbook.widthAnchor.constraint(equalToConstant: 26),
            logoHandbook.heightAnchor.constraint(equalToConstant: 26),
            logoHandbook.bottomAnchor.constraint(equalTo: viewOpacity.bottomAnchor),
            logoHandbook.leadingAnchor.constraint(equalTo: viewOpacity.leadingAnchor)
        ])
    }
}
