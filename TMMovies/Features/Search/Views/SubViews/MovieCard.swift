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
                .accessibilityLabel(Text("Poster for \(movie.title)"))
                .frame(width: 95)
            VStack(alignment: .leading, spacing: 14) {
                Text(movie.title)
                    .customFont(.regular, size: 16)
                    .foregroundStyle(.primaryText)
                VStack(alignment: .leading, spacing: 4) {
                    IconLabelView(
                        iconName: .star,
                        label: "\(movie.voteAverage)",
                        color: .rating,
                        accessibilityLabelLabel: "Vote"
                    )
                    IconLabelView(
                        iconName: .calendarIcon,
                        label: "\(movie.releaseDate)",
                        accessibilityLabelLabel: "Release date"
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
                    .accessibilityLabel(Text("Movie rating: \(movie.adult ? " 18+ Adults Only" : "unknown")"))
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
    let accessibilityLabelLabel: String
    var body: some View {
        HStack {
            Image(iconName)
                .renderingMode(.template)
            Text(label)
                .customFont(.regular, size: 12)
                .lineLimit(1)
        }
        .foregroundStyle(color)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(Text("\(accessibilityLabelLabel): \(label)"))
    }
}

#Preview {
    ZStack {
        Color.background
        MovieCard(movie: Movie.dummyMovie)
    }
}
