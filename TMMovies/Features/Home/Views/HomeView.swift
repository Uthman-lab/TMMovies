//
//  HomeView.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/9/24.
//

import SwiftUI

struct HomeView: View {
    @State var text = ""
    @State private var navigateToSettings: Bool = false
    @StateObject var viewModel = HomeViewModel()
    var body: some View {
        NavigationStack {
            PageWithBackground {
                ScrollView {
                    VStack(alignment: .leading, spacing: 18) {
                        Text("What do you want to watch?")
                            .foregroundStyle(Color(.primaryText))
                            .customFont(.semiBold)
                        MainMovies(
                            movies: viewModel.mainMovies,
                            onPaginationAction: {
                                viewModel.getTrendingMovies()
                            })
                        TabSection(
                            homeViewModel: viewModel
                        )
                        TabBarMovies(
                            moviesState: viewModel.genreMoviesState,
                            onPaginationAction: {
                                viewModel.getPaginatedMovies()
                            },
                            selectedGenre: $viewModel.selectedGenre
                        )

                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom)
            }
            .useTrailingNavbarView(.settingIcon, onTap: {
                navigateToSettings = true
            })
            .navigationDestination(isPresented: $navigateToSettings) {
                SettingsView()
            }
        }
    }
}

struct MainMovies: View {
    let movies: [Movie]
    var onPaginationAction: () -> Void = {}

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 30) {
                if movies.isEmpty {
                    ForEach(1..<5) { index in
                        ImageWithNum(
                            imageData: (URL(string: ""), index)
                        )
                    }
                } else {
                    ForEach(Array(movies.enumerated()), id: \.offset) { index, movie in
                        NavigationLink(destination: {
                            DetailsView(movie: movie)
                        }, label: {
                            ImageWithNum(
                                imageData: (movie.posterImage, index + 1)
                            )
                        })
                    }
                    LoadingView()
                        .onAppear {
                            onPaginationAction()
                        }
                }
            }
        }
        .padding(.bottom, 32)
    }
}

private struct TabSection: View {
    @ObservedObject var homeViewModel: HomeViewModel
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 30) {
                ForEach(Genre.allCases, id: \.rawValue) { genre in
                    GenreTabItem(
                        genre: genre,
                                selectedTab: $homeViewModel.selectedGenre,
                                action: {
                        homeViewModel.setGenre(genre: genre)
                    }

                    )
                }
            }
        }
    }
}

struct TabBarMovies: View {
    var moviesState: [Genre: [Movie]]
    var onPaginationAction: () -> Void = {}
    @Binding var selectedGenre: Genre
    var body: some View {
        ScrollView {
            LazyVGrid(columns: formGrid(), alignment: .leading, content: {
                switch moviesState[selectedGenre] {
                case .none:
                    loadingState()
                case .some(let movies):
                    if movies.isEmpty {
                        loadingState()
                    } else {
                        ForEach(Array(movies.enumerated()), id: \.offset) {
                            (_, movie) in
                            NavigationLink(destination: {
                                DetailsView(movie: movie)
                            }, label: {
                                RoundedImage(url: movie.posterImage)
                                    .frame(height: 145)
                            })
                        }
                        LoadingView()
                            .onAppear {
                           onPaginationAction()
                        }
                    }
                }
            })
        }
        .frame(height: 400)
    }

    func loadingState() -> some View {
        ForEach(1..<5) {
            _ in
            RoundedImage(url: nil)
                .frame(height: 145)
        }
    }
    func formGrid() -> [GridItem] {
        let bounds = UIScreen.main.bounds
        var griditems: [GridItem] = []
        for _ in 1...3 {
            let item = GridItem(
                .flexible(
                    minimum: bounds.width * 0.28,
                    maximum: bounds.width * 0.28
                ), spacing: 16
            )
            griditems.append(item)
        }
        return griditems
    }
}

#Preview {
    HomeView()
}
