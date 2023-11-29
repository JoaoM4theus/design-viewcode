//
//  HomeViewController.swift
//  DesignViewCode
//
//  Created by Joao Matheus on 10/11/23.
//

import UIKit

class HomeViewController: UIViewController {
    
    private lazy var viewAux: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
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
    
    private lazy var cardView: CustomView = {
        let element = CustomView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = UIColor(named: "BlurBackground")
        return element
    }()
    
    private lazy var cardVisualEffect: CustomBlurView = {
        let blurEffect = UIBlurEffect(style: .regular)
        let element = CustomBlurView(effect: blurEffect)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var infoVisualEffect: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemMaterial)
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
        element.textColor = .secondaryLabel
        element.numberOfLines = 2
        return element
    }()
    
    private lazy var handbookTitleLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "RECENT HANDBOOKS"
        element.font = .systemFont(ofSize: 13, weight: .regular)
        element.numberOfLines = 2
        return element
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 160, height: 257)
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.register(HandbooksCollectionViewCell.self,
                                forCellWithReuseIdentifier: HandbooksCollectionViewCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Featured"
        view.backgroundColor = UIColor(named: "PrimaryBackground")
        configureAdditional()
    }

    override func viewDidAppear(_ animated: Bool) {
        setUpConstraints()
    }

    private func configureAdditional() {
        cardView.configureDefault()
        cardVisualEffect.cornerRadius = 30
    }

    private func setUpConstraints() {
        view.addSubview(scrollView)
        scrollView.addSubview(viewAux)
        viewAux.addSubview(backgroundImage)
        viewAux.addSubview(cardView)
        cardView.addSubview(cardVisualEffect)
        cardView.addSubview(infoVisualEffect)
        cardVisualEffect.contentView.addSubview(cardImageView)
        infoVisualEffect.contentView.addSubview(titleLabel)
        infoVisualEffect.contentView.addSubview(durationLabel)
        infoVisualEffect.contentView.addSubview(descriptionLabel)
        viewAux.addSubview(handbookTitleLabel)
        viewAux.addSubview(collectionView)

        NSLayoutConstraint.activate([
            viewAux.topAnchor.constraint(equalTo: scrollView.topAnchor),
            viewAux.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            viewAux.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            viewAux.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            viewAux.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
        ])
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: scrollView.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: viewAux.topAnchor, constant: 170),
            cardView.heightAnchor.constraint(equalToConstant: 350),
            cardView.leadingAnchor.constraint(equalTo: viewAux.leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: viewAux.trailingAnchor, constant: -16),
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
        NSLayoutConstraint.activate([
            handbookTitleLabel.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 40),
            handbookTitleLabel.leadingAnchor.constraint(equalTo: viewAux.leadingAnchor, constant: 16),
        ])
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: handbookTitleLabel.bottomAnchor, constant: 30),
            collectionView.leadingAnchor.constraint(equalTo: viewAux.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: viewAux.trailingAnchor, constant: -16),
            collectionView.heightAnchor.constraint(equalToConstant: 257),
            collectionView.bottomAnchor.constraint(equalTo: viewAux.bottomAnchor, constant: -40)
        ])
    }

}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HandbooksCollectionViewCell.identifier,
                                                            for: indexPath) as? HandbooksCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }

}

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
        element.backgroundColor = .black
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
        return element
    }()

    let gradient = CAGradientLayer()
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        gradient.frame = viewOpacity.frame
        gradient.cornerCurve = .continuous
        gradient.cornerRadius = 30
        gradient.colors = [UIColor.red.cgColor, UIColor.systemPink.cgColor]
    }

    func setUpConstraints() {
        contentView.addSubview(mainView)
        mainView.addSubview(viewBackground)
        mainView.addSubview(visualEffect)
        visualEffect.contentView.addSubview(viewOpacity)
        visualEffect.contentView.addSubview(progressView)
        visualEffect.contentView.addSubview(contentVisualEffect)
        visualEffect.contentView.addSubview(imageHandbook)
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
            viewBackground.heightAnchor.constraint(equalToConstant: 257),
            viewBackground.widthAnchor.constraint(equalToConstant: 160)
        ])
        NSLayoutConstraint.activate([
            visualEffect.topAnchor.constraint(equalTo: mainView.topAnchor),
            visualEffect.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            visualEffect.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            visualEffect.bottomAnchor.constraint(equalTo: mainView.bottomAnchor),
            visualEffect.heightAnchor.constraint(equalToConstant: 257),
            visualEffect.widthAnchor.constraint(equalToConstant: 160)
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
