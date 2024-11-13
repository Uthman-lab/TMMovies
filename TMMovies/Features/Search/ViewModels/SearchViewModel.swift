//
//  SearchViewModel.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/13/24.
//

import Foundation

final class SearchViewModel: ObservableObject {
    @Published var searchState: SearchState = .empty
}

enum SearchState {
    case success(movies: [Movie])
    case loading
    case empty
    case error(message: String)
}
