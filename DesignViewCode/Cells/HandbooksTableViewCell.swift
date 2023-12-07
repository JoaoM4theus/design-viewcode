import UIKit

class HandbooksTableViewCell: UITableViewCell {
    static let identifier = "HandbooksTableViewCell"
    
    private lazy var imageBackground: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.image = UIImage(named: "Background 3")
        element.contentMode = .scaleToFill
        element.layer.masksToBounds = true
        element.layer.cornerRadius = 30
        return element
    }()
    
    private lazy var secondImageBackground: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.image = UIImage(named: "Illustration 1")
        return element
    }()

    private lazy var descriptionLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.textColor = .white
        element.text = "Description"
        element.numberOfLines = 2
        element.font = .systemFont(ofSize: 13, weight: .regular)
        return element
    }()
    
    private lazy var durationLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.textColor = .white
        element.text = "Duration"
        element.numberOfLines = 2
        element.font = .systemFont(ofSize: 13, weight: .semibold)
        return element
    }()
    
    private lazy var titleLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.textColor = .white
        element.text = "Title"
        element.numberOfLines = 0
        element.font = .systemFont(ofSize: 28, weight: .bold)
        return element
    }()
    
    private lazy var logoImageView: UIImageView = {
        let element = UIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.image = UIImage(named: "Logo SwiftUI")
        
        return element
    }()
    
    private lazy var logoView: CustomView = {
        let element = CustomView()
        element.cornerRadius = 20
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = .setRGBColor(red: 24, green: 32, blue: 77, opacity: 1)
        return element
    }()

    override func prepareForReuse() {
        super.prepareForReuse()
        
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        super.layoutIfNeeded()
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        layer.shadowColor = UIColor(named: "Shadow")!.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowRadius = 5
        layer.cornerRadius = 30
        setUpConstraints()
    }

    func configure(course: Course) {
        imageBackground.image = course.courseBackground
        secondImageBackground.image = course.courseBanner
        descriptionLabel.text = course.courseDescription
        durationLabel.text = course.courserSubtitle
        titleLabel.text = course.courseTitle
        logoImageView.image = course.couserIcon
    }

    private func setUpConstraints() {
        contentView.addSubview(imageBackground)
        contentView.addSubview(secondImageBackground)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(durationLabel)
        contentView.addSubview(titleLabel)
        
        secondImageBackground.addSubview(logoView)
        logoView.addSubview(logoImageView)
        
        NSLayoutConstraint.activate([
            imageBackground.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageBackground.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            secondImageBackground.topAnchor.constraint(equalTo: imageBackground.topAnchor, constant: 20),
            secondImageBackground.leadingAnchor.constraint(equalTo: imageBackground.leadingAnchor, constant: 20),
            secondImageBackground.trailingAnchor.constraint(equalTo: imageBackground.trailingAnchor, constant: -20),
            secondImageBackground.heightAnchor.constraint(equalToConstant: 200)
        ])
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40)
        ])
        NSLayoutConstraint.activate([
            durationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            durationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            durationLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -8)
        ])
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            titleLabel.bottomAnchor.constraint(equalTo: durationLabel.topAnchor, constant: -8)
        ])
        NSLayoutConstraint.activate([
            logoView.topAnchor.constraint(equalTo: secondImageBackground.topAnchor),
            logoView.leadingAnchor.constraint(equalTo: secondImageBackground.leadingAnchor),
            logoView.heightAnchor.constraint(equalToConstant: 44),
            logoView.widthAnchor.constraint(equalToConstant: 44)
        ])
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: logoView.topAnchor),
            logoImageView.leadingAnchor.constraint(equalTo: logoView.leadingAnchor),
            logoImageView.trailingAnchor.constraint(equalTo: logoView.trailingAnchor),
            logoImageView.bottomAnchor.constraint(equalTo: logoView.bottomAnchor)
        ])
    }
}
