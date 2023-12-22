//
//  Bundle+.swift
//  SwiftUI_MVVM_Prototype
//
//  Created by Hopee on 22/12/2023.
//

import Foundation

extension Bundle {
    private func getInfo(_ key: String) -> String { infoDictionary?[key] as? String ?? "⚠️" }

    var appName: String           { getInfo("CFBundleName") }
    var displayName: String       { getInfo("CFBundleDisplayName") }
    var language: String          { getInfo("CFBundleDevelopmentRegion") }
    var identifier: String        { getInfo("CFBundleIdentifier") }
    var copyright: String         { getInfo("NSHumanReadableCopyright").replacingOccurrences(of: "\\\\n", with: "\n") }
    
    var build: String          { getInfo("CFBundleVersion") }
    var version: String    { getInfo("CFBundleShortVersionString") }
    
}
