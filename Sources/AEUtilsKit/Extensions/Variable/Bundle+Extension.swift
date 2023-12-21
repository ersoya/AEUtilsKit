//
//  Bundle+Extension.swift
//
//
//  Created by Arda Ersoy on 18.12.2023.
//

import Foundation

public extension Bundle {

    enum Constants {
        static let bundleShortVersion: String = "CFBundleShortVersionString"
        static let bundleVersion: String = "CFBundleVersion"
        static let projPath: String = "lproj"
    }

    var appVersion: String? {
        infoDictionary?[Constants.bundleShortVersion] as? String
    }

    var appBuild: String? {
        infoDictionary?[Constants.bundleVersion] as? String
    }

    static func localized(for language: String) -> Bundle {
        let path = Bundle.main.path(forResource: language, ofType: Constants.projPath)!
        return Bundle(path: path)!
    }
}
