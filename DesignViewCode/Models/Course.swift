//
//  Course.swift
//  DesignViewCode
//
//  Created by Joao Matheus on 29/11/23.
//

import UIKit

struct Course {
    var courseTitle: String
    var courserSubtitle: String
    var courseDescription: String
    var couserIcon: UIImage?
    var courseBanner: UIImage?
    var courseAuthor: [String]?
    var courseGradient: [CGColor]?
    var courseBackground: UIImage?
    
    init(title: String,
         subtitle: String,
         description: String,
         icon: UIImage? = nil,
         banner: UIImage? = nil,
         author: [String]? = nil,
         gradient: [CGColor]? = nil,
         background: UIImage? = nil) {
        self.courseTitle = title
        self.courserSubtitle = subtitle
        self.courseDescription = description
        self.couserIcon = icon
        self.courseBanner = banner
        self.courseAuthor = author
        self.courseGradient = gradient
        self.courseBackground = background
    }
}

let handbooks = [
    Course(
        title: "SwiftUI Handbook",
        subtitle: "80 sections - 9 hours",
        description: "Build an iOS app for iOS 15 with custom layouts, animations and more.",
        icon: UIImage(named: "Logo SwiftUI"),
        banner: UIImage(named: "Illustration 2"),
        author: ["Meng To"],
        gradient: [
            UIColor(red: 0.387, green: 0.041, blue: 0.55, alpha: 1).cgColor,
            UIColor(red: 0.251, green: 0.555, blue: 0.835, alpha: 1).cgColor
        ]
    ),
    Course(
        title: "React Hooks Handbook",
        subtitle: "30 sections - 3 hours",
        description: "A comprehensive series of tutorials on React Hooks and more!",
        icon: UIImage(named: "Logo React"),
        banner: UIImage(named: "Illustration 4"),
        author: ["Meng To", "Stephanie Diep"],
        gradient: [
            UIColor(red: 0.51, green: 0.255, blue: 0.737, alpha: 1).cgColor,
            UIColor(red: 0.883, green: 0.283, blue: 0.523, alpha: 1).cgColor,
            UIColor(red: 0/984, green: 0.647, blue: 0.545, alpha: 1).cgColor
        ]
    )
]
