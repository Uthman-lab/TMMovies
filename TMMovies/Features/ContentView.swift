//
//  ContentView.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/9/24.
//

import SwiftUI

struct ContentView: View {
    init() {
        UITabBar.appearance().unselectedItemTintColor = .secondaryText
    }
    @StateObject var settingsViewModel = SettingsViewModel.main
    var body: some View {
            TabView {
                HomeView()
                    .tabItem {
                        TabBarItem(
                            iconName: .homeIcon,
                            label: "Home"
                        )
                    }
                SearchView()
                    .tabItem {
                        VStack {
                            TabBarItem(
                                iconName: .searchIcon2, label: "Search"
                            )
                        }
                    }
               WishListView()
                .tabItem {
                    TabBarItem(
                        iconName: .watchListIcon,
                        label: "Watch List"
                    )
                }
            }
            .tabViewStyle(.automatic)
            .preferredColorScheme(settingsViewModel.selectedTheme.scheme)
    }
}

struct TabBarItem: View {
    let iconName: ImageResource
    let label: String

    var body: some View {
        VStack {
            Image(iconName)
                .renderingMode(.template)
                .resizable()
            Text(label)
                .foregroundColor(.primary)
        }
    }
}

#Preview {
    ContentView()
}
