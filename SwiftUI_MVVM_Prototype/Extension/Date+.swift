//
//  Date+.swift
//  SwiftUI_MVVM_Prototype
//
//  Created by Hopee on 22/12/2023.
//

import Foundation

extension Date {
    var timeAgo: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .short
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}
