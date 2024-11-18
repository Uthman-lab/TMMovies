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
                        label: "\(movie.voteCount)",
                        color: .rating
                    )
                    IconLabelView(
                        iconName: .actionIcon,
                        label: "Action"
                    )
                    IconLabelView(
                        iconName: .calendarIcon,
                        label: "\(movie.releaseDate)"
                    )
                    IconLabelView(
                        iconName: .clockIcon,
                        label: "139 minutes"
                    )
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