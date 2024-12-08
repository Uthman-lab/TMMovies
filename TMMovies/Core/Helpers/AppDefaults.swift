//
//  AppDefaults.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/26/24.
//

import Foundation

final class AppDefaults {
    let defaults = UserDefaults.standard
    private init() {}
    static let shared = AppDefaults()

    func store(for key: AppDefaultKeys, value: Any) {
        defaults.setValue(value, forKey: key.rawValue)
    }

    func getValue(for key: AppDefaultKeys) -> Any? {
        return defaults.object(forKey: key.rawValue)
    }
}

enum AppDefaultKeys: String {
    case theme, language
}
