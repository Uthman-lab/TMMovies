//
//  SettingsView.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/20/24.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        PageWithBackground {
            ScrollView {
                VStack(spacing: 34) {
                    ThemeCard()
                    ProfileCard(
                        imageString: "globe",
                        title: "English"
                    )
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
