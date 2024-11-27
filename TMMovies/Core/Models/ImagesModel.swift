//
//  ImagesModel.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/22/24.
//

import Foundation

struct MediaDetails: Codable {
    let backdrops: [Backdrop]
    let id: Int
    let logos: [Logo]
    let posters: [Poster]
}

struct Backdrop: Codable, Identifiable {
    var id: String {
        filePath
    }
    let aspectRatio: Double
    let height: Int
    let iso6391: String?
    let filePath: String
    let voteAverage: Double
    let voteCount: Int
    let width: Int

    enum CodingKeys: String, CodingKey {
        case aspectRatio = "aspect_ratio"
        case height
        case iso6391 = "iso_639_1"
        case filePath = "file_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case width
    }
}

struct Logo: Codable {
    // Add fields if needed later, placeholder for an empty array
}

struct Poster: Codable, Identifiable {
    var id: String {
        filePath
    }
    let aspectRatio: Double
    let height: Int
    let iso6391: String?
    let filePath: String
    let voteAverage: Double
    let voteCount: Int
    let width: Int

    enum CodingKeys: String, CodingKey {
        case aspectRatio = "aspect_ratio"
        case height
        case iso6391 = "iso_639_1"
        case filePath = "file_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case width
    }
}

extension Poster {
    var imageURL: URL? {
        APIConfiguration.main.parseImageURL(path: filePath)
    }
}

extension Backdrop {
    var imageURL: URL? {
        APIConfiguration.main.parseImageURL(path: filePath)
    }
}
