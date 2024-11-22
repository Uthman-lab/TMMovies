//
//  MovieDetails.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/21/24.
//

import Foundation


// MARK: - Movie Model
struct MovieDetails: Codable, Identifiable {
    let adult: Bool
    let backdropPath: String?
    let budget: Int
    let genres: [Genre]
    let homepage: String
    let id: Int
    let imdbID: String
    let originCountry: [String]
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String?
    let productionCompanies: [ProductionCompany]?
    let productionCountries: [ProductionCountry]?
    let releaseDate: String
    let revenue: Int
    let runtime: Int
    let spokenLanguages: [Language]
    let status: String
    let tagline: String?
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case budget
        case genres
        case homepage
        case id
        case imdbID = "imdb_id"
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue
        case runtime
        case spokenLanguages = "spoken_languages"
        case status
        case tagline
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }

    // MARK: - Computed Properties
    var coverImage: URL? {
        return APIConfiguration.main.parseImageURL(path: backdropPath ?? "")
    }

    var posterImage: URL? {
        return APIConfiguration.main.parseImageURL(path: posterPath ?? "")
    }
}

// MARK: - Supporting Models

struct Genre: Codable {
    let id: Int
    let name: String
}

struct ProductionCompany: Codable {
    let id: Int
    let logoPath: String?
    let name: String
    let originCountry: String
    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

struct ProductionCountry: Codable {
    let iso3166_1: String
    let name: String
    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}

struct Language: Codable {
    let englishName: String
    let iso639_1: String
    let name: String
    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        case name
    }
}


extension MovieDetails {
    var imdbURL: URL? {
        URL(string: "https://www.imdb.com/title/\(imdbID)/")
    }
    
    var homePageURL: URL? {
        URL(string: homepage)
    }
    
    static var dummyMovie: MovieDetails {
        return MovieDetails(
            adult: false,
            backdropPath: "/18TSJF1WLA4CkymvVUcKDBwUJ9F.jpg",
            budget: 3000000,
            genres: [
                Genre(id: 35, name: "Comedy"),
                Genre(id: 18, name: "Drama"),
                Genre(id: 10749, name: "Romance"),
                Genre(id: 878, name: "Science Fiction")
            ],
            homepage: "https://www.mgm.com/movies/my-old-ass",
            id: 947891,
            imdbID: "tt18559464",
            originCountry: ["US"],
            originalLanguage: "en",
            originalTitle: "My Old Ass",
            overview: "An 18th birthday mushroom trip brings free-spirited Elliott face-to-face with her wisecracking 39-year-old self...",
            popularity: 300.06,
            posterPath: "/yUs4Sw9AyTg2sA1qWBkNpD2mGSj.jpg",
            productionCompanies: [
                ProductionCompany(id: 9350, logoPath: "/xz60JVoUHpOeg1cJbxzMJiwbuL7.png", name: "Indian Paintbrush", originCountry: "US"),
                ProductionCompany(id: 82968, logoPath: "/gRROMOG5bpF6TIDMbfaa5gnFFzl.png", name: "LuckyChap Entertainment", originCountry: "US")
            ],
            productionCountries: [
                ProductionCountry(iso3166_1: "US", name: "United States of America")
            ],
            releaseDate: "2024-09-13",
            revenue: 5671147,
            runtime: 89,
            spokenLanguages: [
                Language(englishName: "English", iso639_1: "en", name: "English")
            ],
            status: "Released",
            tagline: "What would you ask your older self?",
            title: "My Old Ass",
            video: false,
            voteAverage: 6.7,
            voteCount: 123
        )
    }
}
