//
//  AboutMovie.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/21/24.
//

import SwiftUI
import WebKit
import Kingfisher

struct AboutMovie: View {
    @ObservedObject var detailsViewModel: DetailsViewModel
    @State var selectedMediaSection = mediaSections.first
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text(detailsViewModel.movieDetails?.overview ?? "No overview found")
                    .foregroundStyle(.primaryText)
                    .customFont(.regular, size: 12)
                MovieSubInfoView(movieDetails: $detailsViewModel.movieDetails)
               LinksView(movieDetails: $detailsViewModel.movieDetails)
               TabSection(
                selectedSection: $selectedMediaSection,
                sections: mediaSections
               )
                ShowMedia(
                    selectedMedia: $selectedMediaSection,
                    detailsViewModel: detailsViewModel
                )
            }
        }
    }
}

struct MovieSubInfoView: View {
    @Binding var movieDetails: MovieDetails?
    
    var body: some View {
        HStack(spacing: 18) {
            VStack(alignment: .leading) {
                Text("Status")
                Text("Original Language")
                Text("Budget")
                Text("Revenue")
            }
            .foregroundColor(.secondaryText)
            VStack(alignment: .leading) {
                Text(movieDetails?.status ?? "")
                Text(movieDetails?.language ?? "")
                Text(movieDetails?.budget.formatted(.currency(code: "usd")) ?? "")
                Text(movieDetails?.revenue.formatted(.currency(code: "usd")) ?? "")
            }
            .foregroundStyle(.primaryText)
            
        }
        .customFont(.medium, size: 12)
    }
}

struct MovieItem: Hashable {
    let title: String
    let value: String
}

struct ShowMedia: View {
    @Binding var selectedMedia: String?
    @ObservedObject var detailsViewModel: DetailsViewModel
    var body: some View {
        VStack {
            switch selectedMedia {
            case mediaSections[0]:
                VideosView(videos: $detailsViewModel.videos)
            case mediaSections[1]:
                MediaScrollView(
                    items: detailsViewModel.posters,
                    content: { poster in
                        MovieImageView(url: poster.imageURL)
                        .frame(width: 70, height: 100) }
                )
            case mediaSections[2]:
                MediaScrollView(
                    items: detailsViewModel.backdrops,
                    content: { poster in
                        MovieImageView(url: poster.imageURL)
                        .frame(width: 150, height: 100) }
                )
            default:
                EmptyView()
            }
        }
    }
}

struct MovieImageView: View {
    let url: URL?
    @State var enlargeImage = false
    var body: some View {
        Button(action: {
            enlargeImage = true
        }) {
            RoundedImage(url: url)
        }
        .navigationDestination(isPresented: $enlargeImage) {
            KFImage(url)
                .useCustomBackButton()
        }
    }
}

struct MediaScrollView<Item: Identifiable, Content: View>: View {
    let items: [Item]
    let content: (Item) -> Content

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            if items.isEmpty {
                Text("No Media found")
                    .customFont(.semiBold)
                    .foregroundStyle(.primaryText)
            }
            HStack(alignment: .top, spacing: 12) {
                ForEach(items) { item in
                    content(item)
                }
            }
            .padding(.bottom, 24)
        }
    }
}

private let mediaSections = ["Videos", "Posters", "Backdrops"]

#Preview {
    AboutMovie(detailsViewModel: DetailsViewModel(movie: Movie.dummyMovie))
}
