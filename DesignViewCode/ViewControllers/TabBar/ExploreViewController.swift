//
//  ExploreViewController.swift
//  DesignViewCode
//
//  Created by Joao Matheus on 10/11/23.
//

import UIKit
import Combine

class ExploreViewController: UIViewController {
    
    private lazy var backgroundImage: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.image = UIImage(named: "Background02")
        element.contentMode = .scaleAspectFill
        return element
    }()

    private lazy var headerVisualEffect: CustomBlurView = {
        let blurEffect = UIBlurEffect(style: .regular)
        let element = CustomBlurView(effect: blurEffect)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    private lazy var infoHeaderVisualEffect: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .prominent)
        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect, style: .label)
        let element = UIVisualEffectView(effect: vibrancyEffect)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    private lazy var titleLabel: UILabel = {
        let element = UILabel()
        element.adjustsFontSizeToFitWidth = true
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "Recent"
        element.numberOfLines = 0
        element.font = UIFont.boldSystemFont(ofSize: 22)
        return element
    }()
    
    private lazy var scrollView: UIScrollView = {
        let element = UIScrollView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = .clear
        return element
    }()
    
    private lazy var viewHandler: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = .clear
        return element
    }()

    private lazy var sectionsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 160, height: 200)
        layout.minimumLineSpacing = 16
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.layer.masksToBounds = false
        collectionView.backgroundColor = .clear
        collectionView.register(SectionCollectionViewCell.self, forCellWithReuseIdentifier: SectionCollectionViewCell.identifier)
        return collectionView
    }()

    private lazy var topicsLabel: UILabel = {
        let element = UILabel()
        element.adjustsFontSizeToFitWidth = true
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "TOPICS"
        element.numberOfLines = 1
        element.font = UIFont.boldSystemFont(ofSize: 13)
        return element
    }()

    private lazy var topicsBackgroundView: CustomView = {
        let element = CustomView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = .clear
        element.cornerRadius = 30
        element.shadowOpacity = 0.3
        element.shadowOffset = 30
        element.shadowColor = .colorShadow
        return element
    }()

    private lazy var topicsVisualEffect: CustomBlurView = {
        let blurEffect = UIBlurEffect(style: .regular)
        let element = CustomBlurView(effect: blurEffect)
        element.cornerRadius = 30
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    private lazy var topicsTableView: UITableView = {
        let element = UITableView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = .clear
        element.rowHeight = 55
        element.isScrollEnabled = false
        element.layer.masksToBounds = false
        element.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        element.separatorColor = .setRGBColor(red: 0, green: 0, blue: 0, opacity: 0.8)
        element.delegate = self
        element.dataSource = self
        element.register(TopicsTableViewCell.self, forCellReuseIdentifier: TopicsTableViewCell.identifier)
        return element
    }()

    private lazy var popularLabel: UILabel = {
        let element = UILabel()
        element.adjustsFontSizeToFitWidth = true
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "POPULAR"
        element.numberOfLines = 1
        element.font = UIFont.boldSystemFont(ofSize: 13)
        return element
    }()

    private lazy var popularCollectionView: UICollectionView = {
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

    private var tableViewHeight = NSLayoutConstraint()
    private var tokens: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewHeight = topicsBackgroundView.heightAnchor.constraint(equalToConstant: 150)
        topicsTableView.publisher(for: \.contentSize).sink { [weak self] newContentSize in
            guard let self else { return }
            self.tableViewHeight.constant = newContentSize.height
        }.store(in: &tokens)
        setConstraints()
    }

    private func setConstraints() {
        view.addSubview(backgroundImage)
        view.addSubview(headerVisualEffect)
        view.addSubview(scrollView)
        headerVisualEffect.contentView.addSubview(infoHeaderVisualEffect)
        infoHeaderVisualEffect.contentView.addSubview(titleLabel)
        scrollView.addSubview(viewHandler)
        viewHandler.addSubview(sectionsCollectionView)
        viewHandler.addSubview(topicsLabel)
        viewHandler.addSubview(topicsBackgroundView)
        viewHandler.addSubview(topicsVisualEffect)
        viewHandler.addSubview(popularLabel)
        viewHandler.addSubview(popularCollectionView)
        topicsVisualEffect.contentView.addSubview(topicsTableView)

        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            headerVisualEffect.topAnchor.constraint(equalTo: view.topAnchor),
            headerVisualEffect.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerVisualEffect.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerVisualEffect.heightAnchor.constraint(equalToConstant: 120)
        ])
        NSLayoutConstraint.activate([
            infoHeaderVisualEffect.topAnchor.constraint(equalTo: headerVisualEffect.topAnchor),
            infoHeaderVisualEffect.leadingAnchor.constraint(equalTo: headerVisualEffect.leadingAnchor),
            infoHeaderVisualEffect.trailingAnchor.constraint(equalTo: headerVisualEffect.trailingAnchor),
            infoHeaderVisualEffect.bottomAnchor.constraint(equalTo: headerVisualEffect.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: infoHeaderVisualEffect.leadingAnchor, constant: 16),
            titleLabel.bottomAnchor.constraint(equalTo: infoHeaderVisualEffect.bottomAnchor, constant: -16)
        ])
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: headerVisualEffect.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            viewHandler.topAnchor.constraint(equalTo: scrollView.topAnchor),
            viewHandler.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            viewHandler.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            viewHandler.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            viewHandler.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        NSLayoutConstraint.activate([
            sectionsCollectionView.topAnchor.constraint(equalTo: viewHandler.topAnchor, constant: 16),
            sectionsCollectionView.leadingAnchor.constraint(equalTo: viewHandler.leadingAnchor, constant: 16),
            sectionsCollectionView.trailingAnchor.constraint(equalTo: viewHandler.trailingAnchor, constant: -16),
            sectionsCollectionView.heightAnchor.constraint(equalToConstant: 200)
        ])
        NSLayoutConstraint.activate([
            topicsLabel.topAnchor.constraint(equalTo: sectionsCollectionView.bottomAnchor, constant: 30),
            topicsLabel.leadingAnchor.constraint(equalTo: viewHandler.leadingAnchor, constant: 16),
        ])
        NSLayoutConstraint.activate([
            topicsBackgroundView.topAnchor.constraint(equalTo: topicsLabel.bottomAnchor, constant: 16),
            topicsBackgroundView.leadingAnchor.constraint(equalTo: viewHandler.leadingAnchor, constant: 16),
            topicsBackgroundView.trailingAnchor.constraint(equalTo: viewHandler.trailingAnchor, constant: -16),
            tableViewHeight
        ])
        NSLayoutConstraint.activate([
            topicsVisualEffect.topAnchor.constraint(equalTo: topicsBackgroundView.topAnchor),
            topicsVisualEffect.leadingAnchor.constraint(equalTo: topicsBackgroundView.leadingAnchor),
            topicsVisualEffect.trailingAnchor.constraint(equalTo: topicsBackgroundView.trailingAnchor),
            topicsVisualEffect.bottomAnchor.constraint(equalTo: topicsBackgroundView.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            topicsTableView.topAnchor.constraint(equalTo: topicsVisualEffect.topAnchor),
            topicsTableView.leadingAnchor.constraint(equalTo: topicsVisualEffect.leadingAnchor),
            topicsTableView.trailingAnchor.constraint(equalTo: topicsVisualEffect.trailingAnchor),
            topicsTableView.bottomAnchor.constraint(equalTo: topicsVisualEffect.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            popularLabel.topAnchor.constraint(equalTo: topicsBackgroundView.bottomAnchor, constant: 25),
            popularLabel.leadingAnchor.constraint(equalTo: viewHandler.leadingAnchor, constant: 16),
            popularLabel.trailingAnchor.constraint(equalTo: viewHandler.trailingAnchor, constant: -16),
        ])
        NSLayoutConstraint.activate([
            popularCollectionView.topAnchor.constraint(equalTo: popularLabel.bottomAnchor, constant: 16),
            popularCollectionView.leadingAnchor.constraint(equalTo: viewHandler.leadingAnchor, constant: 16),
            popularCollectionView.trailingAnchor.constraint(equalTo: viewHandler.trailingAnchor, constant: -16),
            popularCollectionView.heightAnchor.constraint(equalToConstant: 267),
            popularCollectionView.bottomAnchor.constraint(equalTo: viewHandler.bottomAnchor, constant: -60),
        ])
    }

}

extension ExploreViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == sectionsCollectionView {
            return sections.count
        }
        return handbooks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == sectionsCollectionView {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SectionCollectionViewCell.identifier,
                for: indexPath
            ) as? SectionCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(section: sections[indexPath.row])
            return cell
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HandbooksCollectionViewCell.identifier,
                                                            for: indexPath) as? HandbooksCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(course: handbooks[indexPath.row])
        return cell
    }
}

extension ExploreViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        topics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TopicsTableViewCell.identifier,
            for: indexPath
        ) as? TopicsTableViewCell
        else {
            return UITableViewCell()
        }
        cell.configure(topic: topics[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

class TopicsTableViewCell: UITableViewCell {
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
