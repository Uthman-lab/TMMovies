//
//  MovieStorageModel.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/19/24.
//

import Foundation
import SwiftData

@Model
class MovieStorageModel {
        var adult: Bool
        var backdropPath: String?
        var genreIds: [Int]
        var id: Int
        var originalLanguage: String
        var originalTitle: String
        var overview: String
        var popularity: Double
        var posterPath: String?
        var releaseDate: String
        var title: String
        var video: Bool
        var voteAverage: Double
        var voteCount: Int

        init(
            adult: Bool,
            backdropPath: String?,
            genreIds: [Int],
            id: Int,
            originalLanguage: String,
            originalTitle: String,
            overview: String,
            popularity: Double,
            posterPath: String?,
            releaseDate: String,
            title: String,
            video: Bool,
            voteAverage: Double,
            voteCount: Int
        ) {
            self.adult = adult
            self.backdropPath = backdropPath
            self.genreIds = genreIds
            self.id = id
            self.originalLanguage = originalLanguage
            self.originalTitle = originalTitle
            self.overview = overview
            self.popularity = popularity
            self.posterPath = posterPath
            self.releaseDate = releaseDate
            self.title = title
            self.video = video
            self.voteAverage = voteAverage
            self.voteCount = voteCount
        }

        // Function to convert Movie model to Movie struct
    }

extension MovieStorageModel {
    func toMovie() -> Movie {
        return Movie(
            adult: self.adult,
            backdropPath: self.backdropPath,
            genreIds: self.genreIds,
            id: self.id,
            originalLanguage: self.originalLanguage,
            originalTitle: self.originalTitle,
            overview: self.overview,
            popularity: self.popularity,
            posterPath: self.posterPath,
            releaseDate: self.releaseDate,
            title: self.title,
            video: self.video,
            voteAverage: self.voteAverage,
            voteCount: self.voteCount
        )
    }
}

extension Movie {
    func toMovieStorageModel() -> MovieStorageModel {
        return MovieStorageModel(
            adult: self.adult,
            backdropPath: self.backdropPath,
            genreIds: self.genreIds,
            id: self.id,
            originalLanguage: self.originalLanguage,
            originalTitle: self.originalTitle,
            overview: self.overview,
            popularity: self.popularity,
            posterPath: self.posterPath,
            releaseDate: self.releaseDate,
            title: self.title,
            video: self.video,
            voteAverage: self.voteAverage,
            voteCount: self.voteCount
        )
    }
}
