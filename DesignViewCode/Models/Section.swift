//
//  Section.swift
//  DesignViewCode
//
//  Created by Joao Matheus on 02/12/23.
//

import UIKit


struct Section {
    var sectionTitle: String
    var sectionSubtitle: String
    var sectionDescription: String
    var sectionIcon: UIImage
    var sectionBanner: UIImage
    init(title: String, subtitle: String, description: String, icon: UIImage, banner: UIImage) {
        self.sectionTitle = title
        self.sectionSubtitle = subtitle
        self.sectionDescription = description
        self.sectionIcon = icon
        self.sectionBanner = banner
    }
}

let sections = [
    Section (
        title: "Advanced Custom Layout",
        subtitle: "SwiftUI for iOS 15",
        description: "Build an iOS app for iOS 15 with custom layouts.",
        icon: UIImage(named: "Logo SwiftUI")!,
        banner: UIImage(named: "Illustration 3")!
    ),
    Section (
        title: "Advanced Custom Layout",
        subtitle: "SwiftUI for iOS 15",
        description: "Learn about the formatted(date:time:) method and AsyncImagem",
        icon: UIImage(named: "Logo SwiftUI")!,
        banner: UIImage(named: "Illustration 4")!
    ),
    Section (
        title: "Advanced Custom Layout",
        subtitle: "SwiftUI for iOS 15",
        description: "Learn about the formatted(date:time:) method and AsyncImagem",
        icon: UIImage(named: "Logo Flutter")!,
        banner: UIImage(named: "Illustration 1")!
    )
]
