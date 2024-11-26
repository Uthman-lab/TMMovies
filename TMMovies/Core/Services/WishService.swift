//
//  WishService.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/19/24.
//

import Foundation
import SwiftData
import SwiftUI

final class WishService {

    let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    // Add a movie to SwiftData
    func addMovie(_ movie: Movie) throws {
        let fetchDescriptor = FetchDescriptor<MovieStorageModel>(
            predicate: #Predicate { $0.id == movie.id }
        )

        let existingMovies = try context.fetch(fetchDescriptor)

        guard existingMovies.isEmpty else {
            debugPrint("Movie with ID \(movie.id) already exists.")
            return
        }

        context.insert(movie.toMovieStorageModel())
        try context.save()
    }

    // Delete a movie from SwiftData
    func deleteMovie(_ movie: Movie) throws {
        let id = movie.id
        try context.delete(
            model: MovieStorageModel.self,
            where: #Predicate { movie in
                movie.id == id
            }
        )
        try context.save()
    }

    // Retrieve all movies from SwiftData
    func getAllMovies() throws -> [Movie] {
        do {
            let discriptor = FetchDescriptor<MovieStorageModel>(
                sortBy: [
                    SortDescriptor(
                        \MovieStorageModel.title, order: .reverse
                    )
                ]
            )
            let fetchedData = try  context.fetch(discriptor)
            if fetchedData.isEmpty {
                throw CustomErrors.decode("Empty")
            }
            return fetchedData.map {$0.toMovie()}
        } catch {
            throw CustomErrors.decode("No collections found")
        }
    }
}
