//
//  DetailsView.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/9/24.
//

import SwiftUI

struct DetailsView: View {
    // MARK: - life cycle methods

    init(movie: Movie) {
        self.movie = movie
        _detailsViewModel = StateObject(wrappedValue: DetailsViewModel(movie: movie))
    }

    // MARK: - variables

    let movie: Movie
    @ObservedObject var wishViewModel = WishViewModel.shared
    @State var selectedSection: String? = movieDetailsSections.first
    @StateObject var detailsViewModel: DetailsViewModel

    // MARK: - view

    var body: some View {
        PageWithBackground {
            VStack(alignment: .leading, spacing: 24) {
                HeroView(
                    posterImage: movie.posterImage,
                    image: movie.coverImage,
                    movieTitle: movie.title
                )
                .accessibilityLabel("\(movie.title) backdrop and poster images ")
                VStack(alignment: .leading, spacing: 24) {
                    ChipsView(movie: movie)
                    TabSection(
                        selectedSection: $selectedSection,
                        sections: movieDetailsSections
                    )
                    MovieDetailsView(
                        selectedSection: $selectedSection,
                        viewModel: detailsViewModel
                    )
                }
                .padding(.leading, 34)
                .padding(.trailing, 24)
                Spacer()
            }
        }
        .useCustomBackButton()
        .useTrailingNavbarView(
            wishViewModel.containsMovie(movie) ? .wishIconActive : .wishIcon,
            accessibilityLabel: accessibilityText(movie: movie),
            onTap: {
                if wishViewModel.containsMovie(movie) {
                    wishViewModel.removeMovie(movie)
                } else {
                    wishViewModel.addMovieToWish(movie)
                }
            })

    }

    private func accessibilityText(movie: Movie) -> String {
        if wishViewModel.containsMovie(movie) {
            return "Remove from wishlist toggle"
        }
        return "Add to wishlist toggle"
    }
}

private struct ChipsView: View {
    let movie: Movie
    var body: some View {
        HStack {
            Spacer()
            DetailsViewChip(iconName: .calendarIcon, label: movie.releaseDate )
                .accessibilityLabel(Text("Year of release \(movie.releaseDate)"))
            Text("|")
                .foregroundStyle(.clear)
                .background(
                    Rectangle()
                        .frame(width: 1)
                        .foregroundStyle(.secondaryText)
                )
                .accessibilityLabel(Text(" "))
            DetailsViewChip(
                iconName: .actionIcon,
                label: movie.voteAverage.description
            )
            .accessibilityLabel(Text("Averate rating \(movie.voteAverage.formatted(.number))"))
            Spacer()
        }
    }
}

private struct MovieDetailsView: View {
    @Binding var selectedSection: String?
    @ObservedObject var viewModel: DetailsViewModel
    var body: some View {
        switch selectedSection {
        case movieDetailsSections[0]:
            AboutMovie(detailsViewModel: viewModel)
        case movieDetailsSections[1]:
            ReviewsView(reviews: viewModel.reviews)
        case movieDetailsSections[2]:
            CastsView(castMembers: viewModel.castMembers)
        default:
            EmptyView()
        }
    }
}

private let movieDetailsSections = ["About Movie", "Reviews", "Cast"]

#Preview {
    DetailsView(movie: Movie.dummyMovie)
}
