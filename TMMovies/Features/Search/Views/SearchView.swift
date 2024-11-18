//
//  SearchView.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/13/24.
//

import SwiftUI
import Combine

struct SearchView: View {
    
    @StateObject var searchViewModel = SearchViewModel()
    private var debouncer = Debouncer<String>()

    var body: some View {
        PageWithBackground {
            VStack(spacing: 24) {
                SearchTextField(
                    text: $searchViewModel.text,
                    action: {
                        debouncer.debounce(
                            value: searchViewModel.text
                        ) { debounceValue in
                            searchViewModel.initializeSearch()
                        }
                    })
                Spacer()
                switch searchViewModel.searchState {
                case .success(let movies):
                    MoviesResultsView(
                        movies: movies,
                        searchViewModel: searchViewModel
                    )
                case .loading:
                    LoadingView()
                case .empty:
                    EmptyView()
                case .error(let err):
                    NoResultsView(error: err)
                }
                
            }
            .padding(.horizontal, 24)
            .padding(.bottom)
        }
    }
}

struct MoviesResultsView: View {
    let movies: [Movie]
    @ObservedObject var searchViewModel: SearchViewModel
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 24) {
                ForEach(movies) { movie in
                    NavigationLink(destination: {
                     DetailsView(movie: movie)
                    }, label: {
                        MovieCard(movie: movie)
                    })
                }
                if let error = searchViewModel.paginationError {
                    VStack {
                        Text(error)
                            .customFont(.medium, size: 12)
                            .foregroundStyle(.primaryText)
                        Button("Click to reload") {
                            searchViewModel.search(loadMore: true)
                        }
                    }
                }
                if !searchViewModel.isLastPage {
                    LoadingView()
                        .onAppear {
                            searchViewModel.search(loadMore: true)
                        }
                }
            }
        }
    }
}

struct NoResultsView: View {
    let error: String?
    var body: some View {
        CustomErrorView(
            image: .errorIcon,
            title: error ?? "we are sorry, we can not find the movie :(",
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
            Spacer()
            Image(image)
            Text(title)
                .customFont(.semiBold, size: 16)
                .foregroundStyle(.primaryText)
            Text(message)
                .customFont(.medium, size: 12)
                .foregroundStyle(.secondaryText)
            Spacer()
            Spacer()
        }
        .multilineTextAlignment(.center)
        .frame(width: 188)
    }
}

#Preview {
    SearchView()
}
