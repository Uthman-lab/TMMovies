//
//  File.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/9/24.
//

import Foundation
import Combine

final class APIService {
    let configurations = APIConfiguration.main
    let session = NetworkSession()
    var cancellables = Set<AnyCancellable>()
    
    func getMovies(genre: Genre) throws -> AnyPublisher<MovieResponse, Error> {
       try session.getRequest(path: genre.rawValue)
    }
    
    func getReviews(movie: Movie) throws -> AnyPublisher<MovieReviewResponse, Error> {
        try session.getRequest(path: "\(movie.id)/reviews")
    }
    
    func getCasts(movie: Movie) throws -> AnyPublisher<CastResponse, Error> {
        try session.getRequest(path: "\(movie.id)/credits")
    }
}

enum Genre: String, CaseIterable {
    case popular = "popular"
    case upcoming = "upcoming"
    case topRated = "top_rated"
    case nowPlaying = "now_playing"
    
    var text: String {
        switch self {
        case .popular:
            "Popular"
        case .upcoming:
            "Upcoming"
        case .topRated:
            "Top Rated"
        case .nowPlaying:
            "Now playing"
        }
    }
}
