//
//  MovieCard.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/13/24.
//

import SwiftUI

struct MovieCard: View {
    let movie: Movie
    var body: some View {
        HStack(spacing: 12) {
            RoundedImage(url: movie.posterImage)
                .frame(width: 95)
            VStack(alignment: .leading, spacing: 14) {
                Text(movie.title)
                    .customFont(.regular, size: 16)
                    .foregroundStyle(.primaryText)
                VStack(alignment: .leading, spacing: 4) {
                    IconLabelView(
                        iconName: .star,
                        label: "\(movie.voteAverage)",
                        color: .rating
                    )
                    IconLabelView(
                        iconName: .calendarIcon,
                        label: "\(movie.releaseDate)"
                    )
                    HStack {
                        if movie.adult {
                                   Label("18+ Adults Only", systemImage: "lock.fill")
                                       .foregroundColor(.red)
                               } else {
                                   Label("Unknown", systemImage: "questionmark.circle.fill")
                                       .foregroundColor(.primaryText)
                               }
                           }
                           .font(.caption)
                           .padding(.vertical, 4)
                           .padding(.horizontal, 8)
                           .background(Color(.searchField))
                           .cornerRadius(8)
                    .customFont(.medium, size: 20)
                    .foregroundStyle(.primaryText)
                }
            }
            Spacer()
        }
        .frame(height: 120)
    }
}

private struct IconLabelView: View {
    let iconName: ImageResource
    let label: String
    var color: Color = .primaryText
    var body: some View {
        HStack {
            Image(iconName)
                .renderingMode(.template)
            Text(label)
                .customFont(.regular, size: 12)
                .lineLimit(1)
        }
        .foregroundStyle(color)

    }
}

#Preview {
    ZStack {
        Color.background
        MovieCard(movie: Movie.dummyMovie)
    }
}
