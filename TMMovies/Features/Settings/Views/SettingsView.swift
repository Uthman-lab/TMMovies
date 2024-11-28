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
            ScrollView {
                VStack(spacing: 34) {
                    ThemeCard()
                } .padding()
            }
            .useCustomBackButton()
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
