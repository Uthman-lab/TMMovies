//
//  TextTabItem.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/9/24.
//

import SwiftUI

struct TextTabItem: View {
    let genre: Genre
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        Button(action: {
            withAnimation {
                viewModel.setGenre(genre: genre)
            }
        }) {
            VStack(spacing: 4) {
                Text(genre.text)
                    .customFont(.medium, size: 14)
                    .foregroundStyle(Color(.primaryText))
                if viewModel.selectedGenre == genre {
                    Text(genre.rawValue)
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
    TextTabItem(genre: .nowPlaying, viewModel: HomeViewModel())
}
