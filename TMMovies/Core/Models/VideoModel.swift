//
//  VideoModel.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/21/24.
//

import Foundation


struct VideoResponse: Codable {
    let id: Int
    let results: [MovieVideo]
}

struct MovieVideo: Codable, Identifiable {
    let name: String
    let key: String
    let site: String
    let size: Int
    let type: String
    let official: Bool
    let publishedAt: String
    let id: String

    enum CodingKeys: String, CodingKey {
        case name, key, site, size, type, official
        case publishedAt = "published_at"
        case id
    }
}

extension MovieVideo {
    var youtubeURL: URL? {
        URL(string: "https://www.youtube.com/embed/\(key)")
    }
    
    var thumbNailURL: URL? {
        URL(string: "https://img.youtube.com/vi/\(key)/hqdefault.jpg")
    }
}

extension MovieVideo {
    static var dummyVideo: MovieVideo {
        MovieVideo(
            name: "A | Official Trailer | 2017",
            key: "aFD8oBw0DoA",
            site: "YouTube",
            size: 1080,
            type: "Trailer",
            official: false,
            publishedAt: "2017-08-22T03:15:30.000Z",
            id: "5d50dc209c0550089a44b7a1"
        )
    }
}

