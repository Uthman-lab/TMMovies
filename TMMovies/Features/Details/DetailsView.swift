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
    @State var selectedSection: String? = MovieDetailsSection.aboutMovie.rawValue
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
                VStack(alignment: .leading, spacing: 24) {
                    chipsView(movie: movie)
                    TabSection(
                        selectedSection: $selectedSection)
                    MovieDetails(
                        selectedSection: $selectedSection,
                        viewModel: detailsViewModel,
                        movie: movie
                    )
                }
                .padding(.leading, 34)
                .padding(.trailing, 24)
                Spacer()
            }
        }
        .useCustomBackButton()
        .useTrailingNavbarView(.wishIcon)

    }
}

private struct TabSection: View {
    @Binding var selectedSection: String?
    var body: some View {
        HStack(alignment: .top, spacing: 24) {
            ForEach(MovieDetailsSection.allCases) { section in
                TextTabItem(
                    text: section.rawValue,
                    selectedTab: $selectedSection,
                    action: {
                        selectedSection = section.rawValue
                    })
            }
        }
    }
}

private struct chipsView: View {
    let movie: Movie
    var body: some View {
        HStack {
            Spacer()
            DetailsViewChip(iconName: .calendarIcon, label: movie.releaseDate )
            Text("s")
                .foregroundStyle(.clear)
                .background(
                    Rectangle()
                        .frame(width: 1)
                        .foregroundStyle(.secondaryText)
                )
            DetailsViewChip(iconName: .actionIcon, label: movie.voteAverage.description )
            Spacer()
        }
    }
}

private struct MovieDetails: View {
    @Binding var selectedSection: String?
    @ObservedObject var viewModel: DetailsViewModel
    let movie: Movie
    var body: some View {
        switch selectedSection {
        case MovieDetailsSection.aboutMovie.rawValue:
            AboutMovie(content: movie.overview)
        case MovieDetailsSection.reviews.rawValue:
            ReviewsView(reviews: viewModel.reviews)
        case MovieDetailsSection.cast.rawValue:
            CastsView(castMembers: viewModel.castMembers)
        default:
            EmptyView()
        }
    }
}
private struct AboutMovie: View {
    let content: String
    var body: some View {
        Text(content)
            .foregroundStyle(.primaryText)
            .customFont(.regular, size: 12)
    }
}

struct ReviewsView: View {
    let reviews: [MovieReview]

    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                ForEach(reviews) { review in
                    ReviewCard(review: review)
                }
            }
        }
    }
}

struct CastsView: View {
    let castMembers: [CastMember]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [
                GridItem(.flexible(), alignment: .leading),
                GridItem(.flexible(), alignment: .trailing)
            ]) {
                ForEach(castMembers, id: \.id) { member in
                    CastAvatar(
                        url: member.avatarImage,
                        name: member.name
                    )
                }
            }
        }
    }
}

enum MovieDetailsSection: String, CaseIterable, Identifiable {
    case aboutMovie = "About Movie"
    case reviews = "Reviews"
    case cast = "Cast"
    var id: UUID {
        UUID()
    }
}

#Preview {
    DetailsView(movie: Movie.dummyMovie)
}

struct TextTabItem: View {
    let text: String
    @Binding var selectedTab: String?
    var action: () -> Void

    var body: some View {
        Button(action: {
            withAnimation {
                action()
            }
        }) {
            VStack(spacing: 4) {
                Text(text)
                    .customFont(.medium, size: 14)
                    .foregroundStyle(Color(.primaryText))
                if selectedTab == text {
                    Text(text)
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
