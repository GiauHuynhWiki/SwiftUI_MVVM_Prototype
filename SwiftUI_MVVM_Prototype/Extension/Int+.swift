//
//  Int+.swift
//  SwiftUI_MVVM_Prototype
//
//  Created by Hopee on 22/12/2023.
//

import Foundation

extension Int {
    var formatted: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}
