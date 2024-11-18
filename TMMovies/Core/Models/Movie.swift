//
//  Movie.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/9/24.
//

import Foundation

struct MovieResponse: Codable {
    let page: Int
    let totalPages: Int
    let results: [Movie]
    enum CodingKeys: String, CodingKey {
        case page
        case totalPages = "total_pages"
        case results
    }
}

struct Movie: Codable, Hashable, Identifiable {
    let adult: Bool
    let backdropPath: String?
    let genreIds: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

extension Movie {
    var coverImage: URL? {
        APIConfiguration.main.parseImageURL(path: backdropPath ?? "")
    }
    
    var posterImage: URL? {
        APIConfiguration.main.parseImageURL(path: posterPath ?? "")
    }
    static var dummyMovie: Movie {
        Movie(
            adult: false,
            backdropPath: Optional("/18TSJF1WLA4CkymvVUcKDBwUJ9F.jpg"),
            genreIds: [27, 53, 9648],
            id: 1034541,
            originalLanguage: "en",
            originalTitle: "Terrifier 3",
            overview: "Five years after surviving Art the Clown\'s Halloween massacre, Sienna and Jonathan are still struggling to rebuild their shattered lives. As the holiday season approaches, they try to embrace the Christmas spirit and leave the horrors of the past behind. But just when they think they\'re safe, Art returns, determined to turn their holiday cheer into a new nightmare. The festive season quickly unravels as Art unleashes his twisted brand of terror, proving that no holiday is safe.",
            popularity: 4082.255,
            posterPath: Optional("/63xYQj1BwRFielxsBDXvHIJyXVm.jpg"),
            releaseDate: "2024-10-09",
            title: "Terrifier 3", video: false,
            voteAverage: 7.1,
            voteCount: 738
        )
    }
}

