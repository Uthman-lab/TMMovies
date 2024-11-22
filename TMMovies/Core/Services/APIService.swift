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

    func getMovies(genre: MovieList, page: Int) -> AnyPublisher<MovieResponse, Error> {
        return  session.getRequest(
            path: moviePath(genre.rawValue),
            queryParameters: paginationQuery(page)
        )
    }

    func getMovies(path: String, page: Int) -> AnyPublisher<MovieResponse, Error> {
         session.getRequest(path: path, queryParameters: paginationQuery(page))
    }

    func getReviews(movie: Movie) -> AnyPublisher<MovieReviewResponse, Error> {
         session.getRequest(path: moviePath("\(movie.id)/reviews"))
    }

    func getCasts(movie: Movie) -> AnyPublisher<CastResponse, Error> {
         session.getRequest(path: moviePath("\(movie.id)/credits"))
    }
    
    func getMovieDetails(id: Int) -> AnyPublisher<MovieDetails, Error> {
        session.getRequest(path: moviePath("\(id)"))
   }

    func searchMovies(
        text: String,
        page: Int = 1
    ) -> AnyPublisher<MovieResponse, Error> {
        let query = [
            URLQueryItem(name: "query", value: text),
            URLQueryItem(name: "include_adult", value: "false")
        ] + paginationQuery(page)
        return  session.getRequest(
            path: "search/movie",
            queryParameters: query
        )
    }
    
    func getVideosForMovie(movieId: Int) -> AnyPublisher<VideoResponse, Error> {
        session.getRequest(path: moviePath("\(movieId)/videos"))
    }

    // MARK: - private methods

    private func moviePath(_ path: String) -> String {
        "movie/\(path)"
    }
    
    private func paginationQuery(_ page: Int) -> [URLQueryItem] {
        [ URLQueryItem(name: "page", value: "\(page)")]
    }
}

enum MovieList: String, CaseIterable {
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
