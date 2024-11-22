//
//  HomeViewModel.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/9/24.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {

    // MARK: - life cycle methods

    init() {
        getTrendingMovies()
        getAllGenreMovieTypes()
    }

    // MARK: - public variables
    @Published var mainMovies: [Movie] = []
    @Published var genreMoviesState: [MovieList: [Movie]] = [:]
    @Published var selectedGenre: MovieList = .popular

    // MARK: - private variables

    private var paginationState: [MovieList: (page: Int, totalPages: Int)] = [:]
    private var trendingMoviesPaginationState: (page: Int, totalPages: Int)?
    private let service = APIService()
    private var cancellables = Set<AnyCancellable>()

    // MARK: public methods

    func setGenre(genre: MovieList) {
        selectedGenre = genre
    }

    func getPaginatedMovies() {
        let page = paginationState[selectedGenre]?.page ?? 1
        if canGetMoreMovies(paginationState[selectedGenre]) {
            getMovies(
                genre: selectedGenre,
                page: page
            ) { [weak self] response in
                DispatchQueue.main.async {
                    guard let self = self else {
                        return
                    }
                    let genre = self.selectedGenre
                    self.genreMoviesState[genre]?.append(
                        contentsOf: response.movies
                    )
                    self.paginationState[genre] = (
                        response.page + 1,
                        response.totalPages
                    )
                }
            }
        }
    }

    func getTrendingMovies() {
        let page = trendingMoviesPaginationState?.page ?? 1
        if canGetMoreMovies(trendingMoviesPaginationState) {
            service.getMovies(path: "trending/movie/day", page: page)
                .sink(
                    receiveCompletion: {_ in },
                    receiveValue: { [weak self] movieResults in
                        DispatchQueue.main.async {
                            self?.mainMovies.append(
                                contentsOf: movieResults.movies
                            )
                            self?.trendingMoviesPaginationState = (
                                movieResults.page + 1,
                                movieResults.totalPages
                            )
                        }
                    })
                .store(in: &cancellables)
        }
    }

    // MARK: - private methods

    private func canGetMoreMovies(
        _ state: (page: Int, totalPages: Int)?
    ) -> Bool {
        if let state = state {
            return state.page < state.totalPages || state.page == 1
        }
        return true

    }

    private func getAllGenreMovieTypes() {
        for genre in MovieList.allCases {
            getMoviesForGenre(genre: genre)
        }
    }

    private func getMoviesForGenre(genre: MovieList) {
        getMovies(genre: genre, page: 1) { [weak self] response in
            DispatchQueue.main.async {
                self?.genreMoviesState[genre] = response.movies
                self?.paginationState[genre] = (
                    response.page,
                    response.totalPages
                )
            }
        }
    }

    private func getMovies(
        genre: MovieList,
        page: Int,
        onSuccess: @escaping ( MovieResponse) -> Void
    ) {
        service.getMovies(genre: genre, page: page)
            .sink(
                receiveCompletion: {_ in },
                receiveValue: { response in
                    onSuccess(response)
                }
            )
            .store(in: &cancellables)
    }
}
