//
//  SettingsView.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/20/24.
//

import SwiftUI

struct SettingsView: View {
    @State var showLanguages = false
    @ObservedObject var settingsViewModel = SettingsViewModel.main
    var body: some View {
        PageWithBackground {
            VStack(spacing: 34) {
                ThemeCard()
                Spacer()
                Text(AppStrings.disclaimer)
                    .customFont(.normal, size: 12)
                    .foregroundStyle(.rating)
            }
            .padding()
            .useCustomBackButton()
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
