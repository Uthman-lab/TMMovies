//
//  File.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/9/24.
//

import Foundation
import Combine

final class APIService {
    
    // MARK: - public variables
    
    let configurations = APIConfiguration.main
    let session = NetworkSession()
    var cancellables = Set<AnyCancellable>()
    
    // MARK: - public methods
    
    func getMovies(genre: Genre, page: Int)  -> AnyPublisher<MovieResponse, Error> {
         session.getRequest(path: moviePath(genre.rawValue), page: page)
    }
    
    func getMovies(path: String, page: Int)  -> AnyPublisher<MovieResponse, Error> {
         session.getRequest(path: path, page: page)
    }

    func getReviews(movie: Movie)  -> AnyPublisher<MovieReviewResponse, Error> {
         session.getRequest(path: moviePath("\(movie.id)/reviews"))
    }
    
    func getCasts(movie: Movie)  -> AnyPublisher<CastResponse, Error> {
         session.getRequest(path: moviePath("\(movie.id)/credits"))
    }
    
    func searchMovies(
        text: String,
        page: Int = 1
    )  -> AnyPublisher<MovieResponse, Error> {
        let query = [
            URLQueryItem(name: "query", value: text),
            URLQueryItem(name: "include_adult", value: "true")
        ]
        return  session.getRequest(
            path: "search/movie",
            page: page,
            queryParameters: query
        )
    }
    
    // MARK: - private methods
    
    private func moviePath(_ path: String) -> String {
        "movie/\(path)"
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
