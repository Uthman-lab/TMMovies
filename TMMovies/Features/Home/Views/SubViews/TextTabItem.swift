//
//  TextTabItem.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/9/24.
//

import SwiftUI

struct GenreTabItem: View {
    let genre: MovieList
    @Binding var selectedTab: MovieList
    var action: () -> Void

    var body: some View {
        Button(action: {
            withAnimation {
                action()
            }
        }) {
            VStack(spacing: 4) {
                Text(genre.text)
                    .customFont(.medium, size: 14)
                    .foregroundStyle(Color(.primaryText))
                if selectedTab == genre {
                    Text(genre.text)
                        .customFont(.medium, size: 14)
                        .foregroundStyle(.clear)
                        .frame(height: 4)
                        .background(
                            Rectangle()
                                .foregroundStyle(Color(.secondaryIcon))
                        )
                }
            }
        }
    }
}

#Preview {
    GenreTabItem(
        genre: .nowPlaying,
        selectedTab: .constant(.nowPlaying),
        action: {}
    )
}
