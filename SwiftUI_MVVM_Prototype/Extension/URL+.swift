//
//  URL+.swift
//  SwiftUI_MVVM_Prototype
//
//  Created by Hopee on 22/12/2023.
//

import Foundation

extension URL {
    var formatted: String {
        (host ?? "").replacingOccurrences(of: "www.", with: "")
    }
}
