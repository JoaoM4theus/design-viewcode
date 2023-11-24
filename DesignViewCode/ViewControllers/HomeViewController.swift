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
        collectionView.backgroundColor = .red
        collectionView.translatesAutoresizingMaskIntoConstraints = false
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
        cardView.cornerRadius = 30
        cardView.shadowOpacity = 0.5
        cardView.shadowOffset = 10
        cardView.shadowColor = UIColor(named: "Shadow")!
        cardView.shadowRadius = 20
        cardView.borderWidth = 1
        let color: UIColor = .setHexColor(hex: 0x000000, opacity: 0.2)
        cardView.borderColor = color
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = .brown
    }
}
