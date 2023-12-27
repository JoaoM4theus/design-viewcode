//
//  NotificationsViewController.swift
//  DesignViewCode
//
//  Created by Joao Matheus on 10/11/23.
//

import UIKit
import Combine
import SwiftUI
import FirebaseFirestore

final class NotificationsViewController: UIViewController {
    
    private lazy var backgroundImage: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.image = UIImage(named: "Background 8")
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
        element.text = "Notifications"
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
    
    private lazy var progressCoursesView: CustomView = {
        let element = CustomView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.cornerRadius = 30
        element.shadowOpacity = 0.3
        element.shadowOffset = 30
        element.alpha = 0
        element.shadowColor = UIColor(named: "Shadow")!
        element.shadowRadius = 30
        return element
    }()

    private lazy var progressVisualEffect: CustomBlurView = {
        let blurEffect = UIBlurEffect(style: .regular)
        let element = CustomBlurView(effect: blurEffect)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.cornerRadius = 30
        return element
    }()
    
    private lazy var coursesProgressTableView: UITableView = {
        let element = UITableView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.delegate = self
        element.estimatedRowHeight = 100
        element.rowHeight = UITableView.automaticDimension
//        element.dataSource = self
        element.backgroundColor = .clear
        element.isScrollEnabled = false
        element.register(
            NotificationsTableViewCell.self,
            forCellReuseIdentifier: NotificationsTableViewCell.identifier
        )
        return element
    }()
    
    private var dataSource: UITableViewDiffableDataSource<TBSection, NotificationModel>? = nil
//    private var currentSnapshot: NSDiffableDataSourceSnapshot<TBSection, NotificationModel>? = nil
    private var tableViewHeight = NSLayoutConstraint()
    private var tokens: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewHeight = progressCoursesView.heightAnchor.constraint(equalToConstant: 500)
        coursesProgressTableView.publisher(for: \.contentSize).sink { [weak self] newContentSize in
            guard let self else { return }
            self.tableViewHeight.constant = newContentSize.height + 10
        }.store(in: &tokens)
        
        dataSource = UITableViewDiffableDataSource<TBSection, NotificationModel>(tableView: coursesProgressTableView) {
            (tableView: UITableView, indexPath: IndexPath, item: NotificationModel) -> NotificationsTableViewCell in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationsTableViewCell", for: indexPath) as? NotificationsTableViewCell else {
                fatalError("Can't create new cell")
            }

            cell.configure(notification: item)
            
            return cell
            
        }
        dataSource?.defaultRowAnimation = .fade
        
        Task {
            do {
                try await loadData()
            } catch let err {
                print(err.localizedDescription)
            }
        }
        
        setConstraints()
    }

    private func loadData() async throws {
        var currentSnapshot = NSDiffableDataSourceSnapshot<TBSection, NotificationModel>()
        currentSnapshot.appendSections([.main])
        
        let docs = try await Firestore.firestore().collection("notifications").order(by: "sentAt", descending: false).getDocuments()
        var notifications = [NotificationModel]()
        
        for snapshot in docs.documents {
            let data = try snapshot.data(as: NotificationModel.self)
            notifications.append(data)
        }
        
        currentSnapshot.appendItems(notifications, toSection: .main)
        await dataSource?.apply(currentSnapshot, animatingDifferences: true)
        DispatchQueue.main.async {
            self.progressCoursesView.alpha = 1
        }
    }
    
    private func setConstraints() {
        view.addSubview(backgroundImage)
        view.addSubview(headerVisualEffect)
        view.addSubview(scrollView)
        headerVisualEffect.contentView.addSubview(infoHeaderVisualEffect)
        infoHeaderVisualEffect.contentView.addSubview(titleLabel)
        scrollView.addSubview(viewHandler)
        viewHandler.addSubview(progressCoursesView)
        progressCoursesView.addSubview(progressVisualEffect)
        progressVisualEffect.contentView.addSubview(coursesProgressTableView)

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
            progressCoursesView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            progressCoursesView.leadingAnchor.constraint(equalTo: viewHandler.leadingAnchor, constant: 20),
            progressCoursesView.trailingAnchor.constraint(equalTo: viewHandler.trailingAnchor, constant: -20),
            tableViewHeight,
            progressCoursesView.bottomAnchor.constraint(equalTo: viewHandler.bottomAnchor, constant: -40)
        ])
        NSLayoutConstraint.activate([
            progressVisualEffect.topAnchor.constraint(equalTo: progressCoursesView.topAnchor),
            progressVisualEffect.leadingAnchor.constraint(equalTo: progressCoursesView.leadingAnchor),
            progressVisualEffect.trailingAnchor.constraint(equalTo: progressCoursesView.trailingAnchor),
            progressVisualEffect.bottomAnchor.constraint(equalTo: progressCoursesView.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            coursesProgressTableView.topAnchor.constraint(equalTo: progressVisualEffect.topAnchor),
            coursesProgressTableView.leadingAnchor.constraint(equalTo: progressVisualEffect.leadingAnchor),
            coursesProgressTableView.trailingAnchor.constraint(equalTo: progressVisualEffect.trailingAnchor),
            coursesProgressTableView.bottomAnchor.constraint(equalTo: progressVisualEffect.bottomAnchor)
        ])
    }

}

extension NotificationsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

