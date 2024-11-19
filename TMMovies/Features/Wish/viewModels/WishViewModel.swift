//
//  WishViewModel.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/19/24.
//

import Foundation
import SwiftData

class WishViewModel: ObservableObject {
    var wishService: WishService?
    private init() {
        Task {
            await self.setContext()
        }
    }

    // MARK: - public variables
    static let shared = WishViewModel()
    @Published var wishList: [Movie] = []

    // MARK: - private methods

    @MainActor private func setContext() {
        wishService = WishService(context: container.mainContext)
        getMovies()
    }

    func addMovieToWish(_ movie: Movie) {
        do {
            try wishService?.addMovie(movie)
            getMovies()
        } catch {
            debugPrint(error)
        }
    }

    func removeMovie(_ movie: Movie) {
        do {
            try wishService?.deleteMovie(movie)
            getMovies()
        } catch {
            debugPrint(error)
        }
    }

    func getMovies() {
        do {
            wishList = try wishService?.getAllMovies() ?? []
        } catch {
            debugPrint(error)
            wishList = []
        }
    }
}
