//
//  CoursesViewController.swift
//  DesignViewCode
//
//  Created by Joao Matheus on 02/12/23.
//

import UIKit

class CoursesViewController: UIViewController {
    
    private lazy var viewAux: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = UIColor(named: "PrimaryBackground")
        return element
    }()

    private lazy var scrollView: UIScrollView = {
        let element = UIScrollView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.contentInsetAdjustmentBehavior = .never
        element.backgroundColor = UIColor(named: "PrimaryBackground")
        return element
    }()

    private lazy var bannerBackgroundImage: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.contentMode = .scaleAspectFill
        element.image = UIImage(named: "Background 4")
        return element
    }()
    
    private lazy var bannerImage: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.image = UIImage(named: "Illustration 1")
        element.contentMode = .scaleAspectFit
        return element
    }()
    
    private lazy var headerView: CustomView = {
        let element = CustomView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.cornerRadius = 30
        element.shadowOpacity = 0.3
        element.shadowOffset = 30
        element.shadowColor = UIColor(named: "Shadow")!
        element.shadowRadius = 30
        element.backgroundColor = .clear
        return element
    }()
    
    private lazy var headerVisualEffect: CustomBlurView = {
        let blurEffect = UIBlurEffect(style: .regular)
        let element = CustomBlurView(effect: blurEffect)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.cornerRadius = 30
        return element
    }()

    private lazy var infoVisualEffect: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemThinMaterial)
        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
        let element = UIVisualEffectView(effect: vibrancyEffect)
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    private lazy var titleLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "UIKit for iOS 15"
        element.numberOfLines = 2
        element.font = UIFont.boldSystemFont(ofSize: 28)
        return element
    }()

    private lazy var subtitleLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "UIKit for iOS 15"
        element.font = UIFont.boldSystemFont(ofSize: 13)
        element.numberOfLines = 0
        return element
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "DESCRIPTION LABEL"
        element.numberOfLines = 2
        element.font = UIFont.boldSystemFont(ofSize: 13)
        return element
    }()
    
    private lazy var separatorView: UIView = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = .systemBackground
        element.alpha = 0.4
        return element
    }()
    
    private lazy var authorView: UIView = {
        let element = CustomView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.cornerRadius = 20
        element.shadowOpacity = 0.25
        element.shadowOffset = 10
        element.shadowColor = UIColor(named: "Shadow")!
        element.shadowRadius = 20
        element.backgroundColor = .systemBackground
        element.layer.opacity = 0.4
        return element
    }()
    
    private lazy var authorImage: CustomImageView = {
        let element = CustomImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.image = UIImage(named: "Avatar")
        element.cornerRadius = 10
        return element
    }()

    private lazy var authorLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.text = "Author Name"
        element.font = UIFont.boldSystemFont(ofSize: 13)
        element.numberOfLines = 0
        return element
    }()

    private lazy var progressCoursesView: CustomView = {
        let element = CustomView()
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    var course: Course?
    
    init(course: Course? = nil) {
        self.course = course
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "PrimaryBackground")
        setUpConstraints()
    }

    private func setUpConstraints() {
        view.addSubview(scrollView)
        scrollView.addSubview(viewAux)
        viewAux.addSubview(bannerBackgroundImage)
        bannerBackgroundImage.addSubview(bannerImage)
        viewAux.addSubview(headerView)
        viewAux.addSubview(progressCoursesView)
        headerView.addSubview(headerVisualEffect)
        headerVisualEffect.contentView.addSubview(infoVisualEffect)
        headerVisualEffect.contentView.addSubview(authorView)
        headerVisualEffect.contentView.addSubview(authorLabel)
        infoVisualEffect.contentView.addSubview(titleLabel)
        infoVisualEffect.contentView.addSubview(subtitleLabel)
        infoVisualEffect.contentView.addSubview(descriptionLabel)
        infoVisualEffect.contentView.addSubview(separatorView)
        authorView.addSubview(authorImage)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            viewAux.topAnchor.constraint(equalTo: scrollView.topAnchor),
            viewAux.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            viewAux.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            viewAux.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            viewAux.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        NSLayoutConstraint.activate([
            bannerBackgroundImage.topAnchor.constraint(equalTo: viewAux.topAnchor),
            bannerBackgroundImage.trailingAnchor.constraint(equalTo: viewAux.trailingAnchor),
            bannerBackgroundImage.leadingAnchor.constraint(equalTo: viewAux.leadingAnchor)
        ])
        NSLayoutConstraint.activate([
            bannerImage.topAnchor.constraint(equalTo: viewAux.safeAreaLayoutGuide.topAnchor, constant: 16),
            bannerImage.trailingAnchor.constraint(equalTo: bannerBackgroundImage.trailingAnchor, constant: -16),
            bannerImage.leadingAnchor.constraint(equalTo: bannerBackgroundImage.leadingAnchor, constant: 16),
            bannerImage.bottomAnchor.constraint(equalTo: bannerBackgroundImage.bottomAnchor),
            bannerImage.heightAnchor.constraint(equalToConstant: 350)
        ])
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: bannerBackgroundImage.bottomAnchor, constant: -16),
            headerView.leadingAnchor.constraint(equalTo: viewAux.leadingAnchor, constant: 8),
            headerView.trailingAnchor.constraint(equalTo: viewAux.trailingAnchor, constant: -8)
        ])
        NSLayoutConstraint.activate([
            headerVisualEffect.topAnchor.constraint(equalTo: headerView.topAnchor),
            headerVisualEffect.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            headerVisualEffect.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            headerVisualEffect.bottomAnchor.constraint(equalTo: headerView.safeAreaLayoutGuide.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            infoVisualEffect.topAnchor.constraint(equalTo: headerVisualEffect.topAnchor),
            infoVisualEffect.trailingAnchor.constraint(equalTo: headerVisualEffect.trailingAnchor),
            infoVisualEffect.leadingAnchor.constraint(equalTo: headerVisualEffect.leadingAnchor),
            infoVisualEffect.bottomAnchor.constraint(equalTo: headerVisualEffect.safeAreaLayoutGuide.bottomAnchor),
            infoVisualEffect.heightAnchor.constraint(equalToConstant: 218)
        ])
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: infoVisualEffect.topAnchor, constant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: infoVisualEffect.trailingAnchor, constant: -16),
            titleLabel.leadingAnchor.constraint(equalTo: infoVisualEffect.leadingAnchor, constant: 16)
        ])
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.trailingAnchor.constraint(equalTo: infoVisualEffect.trailingAnchor, constant: -16),
            subtitleLabel.leadingAnchor.constraint(equalTo: infoVisualEffect.leadingAnchor, constant: 16)
        ])
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: infoVisualEffect.trailingAnchor, constant: -16),
            descriptionLabel.leadingAnchor.constraint(equalTo: infoVisualEffect.leadingAnchor, constant: 16)
        ])
        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            separatorView.trailingAnchor.constraint(equalTo: infoVisualEffect.trailingAnchor, constant: -16),
            separatorView.leadingAnchor.constraint(equalTo: infoVisualEffect.leadingAnchor, constant: 16),
            separatorView.heightAnchor.constraint(equalToConstant: 1)
        ])
        NSLayoutConstraint.activate([
            authorView.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 8),
            authorView.leadingAnchor.constraint(equalTo: headerVisualEffect.leadingAnchor, constant: 16),
            authorView.heightAnchor.constraint(equalToConstant: 44),
            authorView.widthAnchor.constraint(equalToConstant: 44),
            authorView.bottomAnchor.constraint(equalTo: headerVisualEffect.bottomAnchor, constant: -8)
        ])
        NSLayoutConstraint.activate([
            authorImage.centerXAnchor.constraint(equalTo: authorView.centerXAnchor),
            authorImage.centerYAnchor.constraint(equalTo: authorView.centerYAnchor),
            authorImage.heightAnchor.constraint(equalToConstant: 26),
            authorImage.widthAnchor.constraint(equalToConstant: 26)
        ])
        NSLayoutConstraint.activate([
            authorLabel.leadingAnchor.constraint(equalTo: authorView.trailingAnchor, constant: 16),
            authorLabel.trailingAnchor.constraint(equalTo: headerVisualEffect.trailingAnchor, constant: -16),
            authorLabel.centerYAnchor.constraint(equalTo: authorView.centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            progressCoursesView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 30),
            progressCoursesView.leadingAnchor.constraint(equalTo: viewAux.leadingAnchor, constant: 16),
            progressCoursesView.trailingAnchor.constraint(equalTo: viewAux.trailingAnchor, constant: -16),
            progressCoursesView.heightAnchor.constraint(equalToConstant: 500),
            progressCoursesView.bottomAnchor.constraint(equalTo: viewAux.bottomAnchor, constant: -40)
        ])
    }
}
