//
//  NotifiationModel.swift
//  DesignViewCode
//
//  Created by Joao Matheus on 27/12/23.
//

import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift

enum TBSection: CaseIterable {
    case main
}

struct NotificationModel: Hashable, Codable {
    @DocumentID var id: String?
    let title: String
    let message: String
    let subtitle: String
    let image: String
    let sentAt: Timestamp
}
