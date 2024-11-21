//
//  ThemeCard.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/21/24.
//

import SwiftUI

struct ThemeCard: View {
    @StateObject var settingsViewModel = SettingsViewModel.main
    var body: some View {
        VStack {
            Text("Theme")
                .customFont(.semiBold, size: 16)
                .foregroundStyle(.primaryText)
            HStack {
                ForEach(Theme.allCases) { theme in
                    ThemeChip(
                        theme: theme,
                        action: {
                            withAnimation(.easeInOut(duration: 1)) {
                                settingsViewModel.setTheme(theme: theme)
                            }
                        },
                        selectedTheme: $settingsViewModel.selectedTheme
                    )
                }
            }
        }
        .padding()
        .background(Color(.card))
        .clipShape(.rect(cornerRadius: 20))
    }
}

private struct ThemeChip: View {
    let theme: Theme
    var action: () -> Void = {}
    @Binding var selectedTheme: Theme

    var body: some View {
        Button(action: action) {
            HStack {
                Spacer()
                VStack(spacing: 8) {
                    Text(theme.label)
                    Image(systemName: theme.iconName)
                }
                Spacer()
            }
            .padding(.vertical)
            .background(
                selectedTheme == theme ? Color(.tintColor) : Color(.background)
            )
            .foregroundStyle(.primaryText)
        }
        .clipShape(.rect(cornerRadius: 20))
        .padding(.horizontal, 2)
    }
}

#Preview {
    ThemeCard()
}
