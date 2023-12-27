//
//  LibraryViewController.swift
//  DesignViewCode
//
//  Created by Joao Matheus on 10/11/23.
//

import UIKit
import Combine
import SwiftUI

final class LibraryViewController: UIViewController {
    
    private lazy var backgroundImage: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.image = UIImage(named: "Background 7")
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
        element.text = "Library"
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

    private lazy var certificatesLabel: UILabel = {
        let element = UILabel()
        element.adjustsFontSizeToFitWidth = true
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "CERTIFICATES"
        element.numberOfLines = 1
        element.textColor = .systemBackground
        element.font = UIFont.boldSystemFont(ofSize: 13)
        return element
    }()

    private lazy var containerView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
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
        createCertificatesView()
    }

    private func createCertificatesView() {
        let hostingController = UIHostingController(rootView: CertificateView())
        hostingController.view.backgroundColor = .clear
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(hostingController)
        containerView.addSubview(hostingController.view)
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        hostingController.didMove(toParent: self)
    }

    private func setConstraints() {
        view.addSubview(backgroundImage)
        view.addSubview(headerVisualEffect)
        view.addSubview(scrollView)
        headerVisualEffect.contentView.addSubview(infoHeaderVisualEffect)
        infoHeaderVisualEffect.contentView.addSubview(titleLabel)
        scrollView.addSubview(viewHandler)
        viewHandler.addSubview(sectionsCollectionView)
        viewHandler.addSubview(topicsBackgroundView)
        viewHandler.addSubview(topicsVisualEffect)
        viewHandler.addSubview(certificatesLabel)
        viewHandler.addSubview(containerView)
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
            topicsBackgroundView.topAnchor.constraint(equalTo: sectionsCollectionView.bottomAnchor, constant: 40),
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
            certificatesLabel.topAnchor.constraint(equalTo: topicsBackgroundView.bottomAnchor, constant: 25),
            certificatesLabel.leadingAnchor.constraint(equalTo: viewHandler.leadingAnchor, constant: 16),
            certificatesLabel.trailingAnchor.constraint(equalTo: viewHandler.trailingAnchor, constant: -16)
        ])
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: certificatesLabel.bottomAnchor, constant: 16),
            containerView.leadingAnchor.constraint(equalTo: viewHandler.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: viewHandler.trailingAnchor, constant: -16),
            containerView.heightAnchor.constraint(equalToConstant: 240),
            containerView.bottomAnchor.constraint(equalTo: viewHandler.bottomAnchor, constant: -100),
        ])
    }

}

extension LibraryViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: SectionCollectionViewCell.identifier,
            for: indexPath
        ) as? SectionCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(section: sections[indexPath.row])
        return cell
    }
}

extension LibraryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        librarySettings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TopicsTableViewCell.identifier,
            for: indexPath
        ) as? TopicsTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(topic: librarySettings[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
