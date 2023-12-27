//
//  String+Localizable.swift
//  DesignViewCode
//
//  Created by Joao Matheus on 27/12/23.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: self)
    }
}
