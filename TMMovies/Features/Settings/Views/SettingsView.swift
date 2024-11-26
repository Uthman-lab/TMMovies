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
                    ProfileCard(
                        imageString: "globe",
                        action:  {
                            showLanguages.toggle()
                        }, 
                        title: settingsViewModel.selectedLanguage?.name ?? ""
                    )
                } .padding()
            }
            .useCustomBackButton()
            .navigationTitle("Settings")
            .sheet(isPresented: $showLanguages) {
                LanguageListView(settingsViewModel: settingsViewModel)
            }
        }
    }
}

struct DeviceLanguage: Hashable {
    let name: String
    let code: String
}

struct LanguageListView: View {
    @ObservedObject var settingsViewModel: SettingsViewModel
    var body: some View {
        NavigationView {
            ScrollViewReader { proxy in
                List(selection: $settingsViewModel.selectedLanguage) {
                    ForEach(settingsViewModel.loadLanguages(), id: \.self) { language in
                        VStack(alignment: .leading) {
                            Text(language.name)
                                .font(.headline)
                            Text("Code: \(language.code)")
                                .font(.subheadline)
                        }
                        .tag(language) // Associate the tag for selection
                    }
                }
                .customTitle("Available Languages")
                .onAppear {
                    if let selectedLanguage = settingsViewModel.selectedLanguage {
                        withAnimation {
                            proxy.scrollTo(selectedLanguage, anchor: .center)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
