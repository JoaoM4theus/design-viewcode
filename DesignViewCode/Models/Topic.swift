//
//  Topic.swift
//  DesignViewCode
//
//  Created by Joao Matheus on 15/12/23.
//

import Foundation

struct Topic {
    var topicName: String
    var topicSymbol: String
}

let topics = [
    Topic(topicName: "iOS Development", topicSymbol: "iphone"),
    Topic(topicName: "UI Design", topicSymbol: "eyedropper"),
    Topic(topicName: "Web Development", topicSymbol: "desktopcomputer")
]

let librarySettings = [
    Topic(topicName: "History", topicSymbol: "clock.fill"),
    Topic(topicName: "Favorites", topicSymbol: "star.fill"),
    Topic(topicName: "Downloads", topicSymbol: "square.and.arrow.down.fill")
]
