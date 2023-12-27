//
//  HomeViewController.swift
//  DesignViewCode
//
//  Created by Joao Matheus on 10/11/23.
//

import UIKit
import Combine

final class HomeViewController: UIViewController {
    
    private var tableViewHeight = NSLayoutConstraint()
    private lazy var viewAux: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    private lazy var scrollView: UIScrollView = {
        let element = UIScrollView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.contentInsetAdjustmentBehavior = .never
        element.backgroundColor = UIColor(named: "PrimaryBackground")
        element.delegate = self
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
        element.adjustsFontForContentSizeCategory = true
        element.maximumContentSizeCategory = .accessibilityExtraLarge
        element.font = UIFont.preferredFont(for: .title1, weight: .bold)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "UIKit for iOS 15"
        return element
    }()
    
    private lazy var durationLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "20 SECTIONS - 3 HOURS"
        element.adjustsFontForContentSizeCategory = true
        element.maximumContentSizeCategory = .accessibilityExtraLarge
        element.font = UIFont.preferredFont(for: .title1, weight: .bold)
        return element
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let element = UILabel()
        element.adjustsFontForContentSizeCategory = true
        element.maximumContentSizeCategory = .accessibilityMedium
        element.font = UIFont.preferredFont(for: .footnote, weight: .regular)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "Build an iOS app for iOS 15 with custom layouts, animations and more!"
        element.textColor = .secondaryLabel
        element.numberOfLines = 2
        return element
    }()
    
    private lazy var handbookTitleLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "RECENT HANDBOOKS"
        element.adjustsFontForContentSizeCategory = true
        element.maximumContentSizeCategory = .accessibilityMedium
        element.font = UIFont.preferredFont(for: .footnote, weight: .regular)
        element.numberOfLines = 2
        return element
    }()
    
    private lazy var coursesTitleLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "RECENT COURSES"
        element.adjustsFontForContentSizeCategory = true
        element.maximumContentSizeCategory = .accessibilityMedium
        element.font = UIFont.preferredFont(for: .footnote, weight: .regular)
        element.numberOfLines = 2
        return element
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 160, height: 267)
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.register(HandbooksCollectionViewCell.self,
                                forCellWithReuseIdentifier: HandbooksCollectionViewCell.identifier)
        collectionView.layer.masksToBounds = false
        return collectionView
    }()
    
    private lazy var tableView: UITableView = {
        let element = UITableView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = .clear
        element.rowHeight = 400
        element.delegate = self
        element.dataSource = self
        element.layer.masksToBounds = false
        element.register(HandbooksTableViewCell.self,
                         forCellReuseIdentifier: HandbooksTableViewCell.identifier)
        return element
    }()
    
    private var tokens: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Featured"
        view.backgroundColor = .clear
        tableViewHeight = tableView.heightAnchor.constraint(equalToConstant: 400)
        configureAdditional()
        setUpConstraints()
    }

    private func configureAdditional() {
        cardView.configureDefault()
        cardVisualEffect.cornerRadius = 30
        tableView.publisher(for: \.contentSize).sink { [weak self] newContentSize in
            guard let self else { return }
            self.tableViewHeight.constant = newContentSize.height
        }.store(in: &tokens)
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
        viewAux.addSubview(coursesTitleLabel)
        viewAux.addSubview(tableView)

        NSLayoutConstraint.activate([
            viewAux.topAnchor.constraint(equalTo: scrollView.topAnchor),
            viewAux.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            viewAux.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            viewAux.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            viewAux.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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
            collectionView.heightAnchor.constraint(equalToConstant: 267)
        ])
        NSLayoutConstraint.activate([
            coursesTitleLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 40),
            coursesTitleLabel.leadingAnchor.constraint(equalTo: viewAux.leadingAnchor, constant: 16)
        ])
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: coursesTitleLabel.bottomAnchor, constant: 15),
            tableView.leadingAnchor.constraint(equalTo: viewAux.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: viewAux.trailingAnchor, constant: -16),
            tableViewHeight,
            tableView.bottomAnchor.constraint(equalTo: viewAux.bottomAnchor, constant: -100)
        ])
    }

}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        handbooks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HandbooksCollectionViewCell.identifier,
                                                            for: indexPath) as? HandbooksCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(course: handbooks[indexPath.row])
        return cell
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        courses.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: HandbooksTableViewCell.identifier,
            for: indexPath) as? HandbooksTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(course: courses[indexPath.section])
        return cell
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 5))
        return view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedCourses = courses[indexPath.section]
        let viewController = CoursesViewController(course: selectedCourses)
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .crossDissolve
        present(viewController, animated: true)
    }
}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentHeight = scrollView.contentSize.height
        let lastScrollYPos = scrollView.contentOffset.y
        
        let percentage = lastScrollYPos / contentHeight
        if percentage <= 0.15 {
            self.title = "Featured"
            return
        }
        if percentage <= 0.33 {
            self.title = "Handbooks"
            return
        }
        self.title = "Courses"
        return
    }
}

