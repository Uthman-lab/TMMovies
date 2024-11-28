//
//  SearchViewModel.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/13/24.
//

import Foundation
import Combine

final class SearchViewModel: ObservableObject {

    // MARK: - public variables

    @Published private(set) var searchState: SearchState = .empty
    @Published var text = ""
    @Published private(set) var paginationError: String?
    @Published private(set) var isLastPage = false

    // MARK: - private variables
    
    private let movieAPI = APIService()
    private var movies: [Movie] = []
    private var cancellables = Set<AnyCancellable>()
    private var page = 1

    // MARK: - public methods

    func initializeSearch() {
        isLastPage = false
        search()
    }

    func search(loadMore: Bool = false) {
            guard !isLastPage else {
                return
            }
            setLoadingState(loadMore: loadMore)
            searchRequest(loadMore: loadMore)
    }

    // MARK: - private methods

    private func setLoadingState(loadMore: Bool) {
        if loadMore {
            paginationError = nil
            page += 1
        } else {
            page = 1
            paginationError = nil
            searchState = .loading
        }
    }

    private func searchRequest(loadMore: Bool) {
         movieAPI.searchMovies(text: text.lowercased())
            .sink(receiveCompletion: { completion in
                DispatchQueue.main.async { [weak self] in
                    switch completion {
                    case .failure(let failure):
                        self?.setErrorState(loadMore: loadMore)
                        debugPrint(failure)
                    case .finished:
                        return
                    }
                }

            }, receiveValue: { moviesResult in
                DispatchQueue.main.async { [weak self] in
                    if moviesResult.movies.isEmpty {
                        self?.searchState = .error(message: AppStrings.noResultFound)
                    } else {
                        self?.setMovies(
                            loadMore: loadMore,
                            moviesResult: moviesResult
                        )
                    }
                }
            })
            .store(in: &cancellables)
    }

    private func setMovies(
        loadMore: Bool,
        moviesResult: MovieResponse
    ) {
        if loadMore {
            isLastPage = isLastPage(
                totalPages: moviesResult.totalPages
            )
            movies += moviesResult.movies
            searchState = .success(movies: movies)
        } else {
            movies = moviesResult.movies
            searchState = movies.isEmpty
                ? .error(message: AppStrings.noResultFound)
                : .success(movies: movies)
        }
    }

    private func isLastPage(totalPages: Int) -> Bool {
        totalPages <= page
    }

    private func setErrorState(loadMore: Bool) {
        if loadMore {
            paginationError = AppStrings.errorMessage
        } else {
            searchState = .error(message: AppStrings.errorMessage)
        }
    }
}

enum SearchState {
    case success(movies: [Movie])
    case loading
    case empty
    case error(message: String)
}

class AppStrings {
    static let errorMessage = "Oops, Something went wrong!"
    static let noResultFound = "we are sorry, we can not find the movie in TMDB's database :("
}
