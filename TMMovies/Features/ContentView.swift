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
    var body: some View {
        NavigationStack {
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
                PageWithBackground {
                    HStack {
                        Spacer()
                        Image(.noResultsIcon)
                        Spacer()
                    }
                }
                .tabItem {
                    TabBarItem(
                        iconName: .watchListIcon,
                        label: "Watch List"
                    )
                }
            }
            .tabViewStyle(.automatic)
        }
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