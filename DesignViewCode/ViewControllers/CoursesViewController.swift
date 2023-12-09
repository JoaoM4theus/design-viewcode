//
//  CoursesViewController.swift
//  DesignViewCode
//
//  Created by Joao Matheus on 02/12/23.
//

import UIKit
import Combine

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
        let blurEffect = UIBlurEffect(style: .prominent)
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
        element.cornerRadius = 30
        element.shadowOpacity = 0.3
        element.shadowOffset = 30
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
    
    private lazy var dismissButton: UIButton = {
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        element.tintColor = UIColor.black
        element.setImage(UIImage(systemName: "xmark"), for: .normal)
        element.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0.7)
        element.layer.cornerRadius = 36 / 2
        return element
    }()
 
    private lazy var logoMenuVisualEffect: CustomBlurView = {
        let blurEffect = UIBlurEffect(style: .regular)
        let element = CustomBlurView(effect: blurEffect)
        element.translatesAutoresizingMaskIntoConstraints = false
        element.cornerRadius = 20
        return element
    }()

    private lazy var menuButton: UIButton = {
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.showsMenuAsPrimaryAction = true
        element.menu = menu()
        return element
    }()

    private lazy var logoMenuImageView: CustomImageView = {
        let element = CustomImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = UIColor(named: "PrimaryBackground")
        element.cornerRadius = 10
        element.isUserInteractionEnabled = false
        return element
    }()
    
    private lazy var coursesProgressTableView: UITableView = {
        let element = UITableView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.delegate = self
        element.dataSource = self
        element.backgroundColor = .clear
        element.rowHeight = 133
        element.isScrollEnabled = false
        element.register(
            CoursesProgressTableViewCell.self,
            forCellReuseIdentifier: CoursesProgressTableViewCell.identifier
        )
        return element
    }()
    
    private var course: Course?
    private var tableViewHeight = NSLayoutConstraint()
    private var tokens: Set<AnyCancellable> = []
    
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
        bannerImage.image = course?.courseBanner
        bannerBackgroundImage.image = course?.courseBackground
        titleLabel.text = course?.courseTitle
        subtitleLabel.text = course?.courserSubtitle
        descriptionLabel.text = course?.courseDescription
        authorLabel.text = "Taugh by \(course?.courseAuthor?.formatted(.list(type: .and, width: .standard)) ?? "")"
        logoMenuImageView.image = course?.couserIcon
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableViewHeight = progressCoursesView.heightAnchor.constraint(equalToConstant: 500)
        coursesProgressTableView.publisher(for: \.contentSize).sink { [weak self] newContentSize in
            guard let self else { return }
            self.tableViewHeight.constant = newContentSize.height
        }.store(in: &tokens)
        setUpConstraints()
    }

    private func setUpConstraints() {
        view.addSubview(scrollView)
        view.addSubview(dismissButton)
        view.addSubview(logoMenuVisualEffect)
        view.addSubview(menuButton)
        logoMenuVisualEffect.contentView.addSubview(logoMenuImageView)
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
        progressCoursesView.addSubview(progressVisualEffect)
        progressVisualEffect.contentView.addSubview(coursesProgressTableView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            dismissButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            dismissButton.heightAnchor.constraint(equalToConstant: 36),
            dismissButton.widthAnchor.constraint(equalToConstant: 36)
        ])
        NSLayoutConstraint.activate([
            logoMenuVisualEffect.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            logoMenuVisualEffect.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            logoMenuVisualEffect.heightAnchor.constraint(equalToConstant: 44),
            logoMenuVisualEffect.widthAnchor.constraint(equalToConstant: 44)
        ])
        NSLayoutConstraint.activate([
            menuButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            menuButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            menuButton.heightAnchor.constraint(equalToConstant: 44),
            menuButton.widthAnchor.constraint(equalToConstant: 44)
        ])
        NSLayoutConstraint.activate([
            logoMenuImageView.centerXAnchor.constraint(equalTo: logoMenuVisualEffect.centerXAnchor),
            logoMenuImageView.centerYAnchor.constraint(equalTo: logoMenuVisualEffect.centerYAnchor),
            logoMenuImageView.heightAnchor.constraint(equalToConstant: 26),
            logoMenuImageView.widthAnchor.constraint(equalToConstant: 26)
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
            headerView.topAnchor.constraint(equalTo: bannerBackgroundImage.bottomAnchor, constant: -150),
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
            tableViewHeight,
            progressCoursesView.bottomAnchor.constraint(equalTo: viewAux.bottomAnchor, constant: -40)
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
    
    @objc
    func dismissView() {
        dismiss(animated: true)
    }
    
    private func menu() -> UIMenu {
        let menu = UIMenu(title: "Course Options", options: .displayInline, children: [
            UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up"), handler: { _ in
            }),
            UIAction(title: "Take Test", image: UIImage(systemName: "highlighter"), handler: { _ in
            }),
            UIAction(title: "Download", image: UIImage(systemName: "square.and.arrow.down"), handler: { _ in
            }),
            UIAction(title: "Forums", image: UIImage(systemName: "chevron.left.forwardslash.chevron.right"), handler: { _ in
            })
        ])
        return menu
    }
}

extension CoursesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return course?.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = course?.sections?[indexPath.row],
              let cell = tableView.dequeueReusableCell(
            withIdentifier: CoursesProgressTableViewCell.identifier,
            for: indexPath
        ) as? CoursesProgressTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(section: section)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        30
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

class CoursesProgressTableViewCell: UITableViewCell {
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
