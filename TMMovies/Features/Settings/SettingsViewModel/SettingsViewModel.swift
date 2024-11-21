//
//  SettingsViewModel.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/21/24.
//

import Foundation
import SwiftUI

final class SettingsViewModel: ObservableObject {
    private init() {
        getTheme()
    }
    static let main = SettingsViewModel()
    @Published var selectedTheme: Theme = .system
    let defaults = UserDefaults.standard
    let themeKey = "theme"

    func setTheme(theme: Theme) {
        defaults.setValue(theme.rawValue, forKey: themeKey)
        getTheme()
    }

    func getTheme() {
        let themeId = defaults.object(forKey: themeKey) as? Int
        switch themeId {
        case 0:
            selectedTheme = Theme.light
        case 1:
            selectedTheme = Theme.dark
        case 2:
            selectedTheme = Theme.system
        default:
            selectedTheme = Theme.dark
        }
    }
}

enum Theme: Int, CaseIterable, Identifiable {
    var id: UUID {
        UUID()
    }

    case light
    case dark
    case system

    var label: String {
        switch self {
        case .light:
            "Light"
        case .dark:
            "Dark"
        case .system:
            "System"
        }
    }

    var iconName: String {
        switch self {
        case .light:
            "sun.max"
        case .dark:
            "moon"
        case .system:
            "gearshape"
        }
    }

    var scheme: ColorScheme? {
        switch self {
        case .light:
                .light
        case .dark:
                .dark
        case .system:
                nil
        }
    }
}
