//
//  DetailsView.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/9/24.
//

import SwiftUI

struct DetailsView: View {
    let movie: Movie
    var body: some View {
        PageWithBackground {
            VStack(spacing: 24) {
                HeroView(
                    posterImage: movie.posterImage,
                    image: movie.coverImage,
                    movieTitle: movie.title
                )
                chipsView(movie: movie)
                Spacer()
            }
        }
    }
}

private struct chipsView: View {
    let movie: Movie
    var body: some View {
        HStack {
            DetailsViewChip(iconName: .calendarIcon, label: movie.releaseDate )
            Text("s")
                .foregroundStyle(.clear)
                .background(
                    Rectangle()
                        .frame(width: 1)
                        .foregroundStyle(.secondaryText)
                )
            DetailsViewChip(iconName: .actionIcon, label: movie.voteAverage.description )
        }
    }
}

#Preview {
    DetailsView(movie: Movie.dummyMovie)
}
