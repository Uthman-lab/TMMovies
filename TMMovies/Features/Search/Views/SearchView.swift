//
//  SearchView.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/13/24.
//

import SwiftUI

struct SearchView: View {
    @State var searchText = ""
    @StateObject var searchViewModel = SearchViewModel()
    var body: some View {
        PageWithBackground {
            VStack(spacing: 24) {
                SearchTextField(text: $searchText)
                Spacer()
                switch searchViewModel.searchState {
                case .success(let movies):
                    MoviesResultsView(movies: movies)
                case .loading:
                    VStack {
                        ProgressView()
                    }
                case .empty:
                    EmptyView()
                case .error(_):
                    NoResultsView()
                }
                Spacer()
                Spacer()
            }
            .padding(.horizontal, 24)
        }
    }
}

struct MoviesResultsView: View {
    let movies: [Movie]
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                ForEach(movies) { movie in
                    MovieCard(movie: movie)}
            }
        }
    }
}

struct NoResultsView: View {
    var body: some View {
        CustomErrorView(
            image: .errorIcon,
            title: "we are sorry, we can not find the movie :(",
            message: "Find your movie by Type title, categories, years, etc"
        )
    }
}

struct EmptyView: View {
    var body: some View {
        CustomErrorView(
            image: .noResultsIcon,
            title: "There is no movie yet!",
            message: "Find your movie by Type title, categories, years, etc "
        )
    }
}

struct CustomErrorView: View {
    let image: ImageResource
    let title: String
    let message: String
    var body: some View {
        VStack(spacing: 12) {
            Image(image)
            Text(title)
                .customFont(.semiBold, size: 16)
                .foregroundStyle(.primaryText)
            Text(message)
                .customFont(.medium, size: 12)
                .foregroundStyle(.secondaryText)
        }
        .multilineTextAlignment(.center)
        .frame(width: 188)
    }
}
#Preview {
    SearchView()
}
