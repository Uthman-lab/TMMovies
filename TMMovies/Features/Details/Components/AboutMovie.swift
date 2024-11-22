//
//  AboutMovie.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/21/24.
//

import SwiftUI
import WebKit

struct AboutMovie: View {
    @ObservedObject var detailsViewModel: DetailsViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(detailsViewModel.movieDetails?.overview ?? "No overview found")
                    .foregroundStyle(.primaryText)
                    .customFont(.regular, size: 12)
                
                VideosView(videos: $detailsViewModel.videos)
            }
        }
    }
}

private let mediaSections = ["Videos", "Posters", "Backdrops"]

#Preview {
    AboutMovie(detailsViewModel: DetailsViewModel(movie: Movie.dummyMovie))
}
