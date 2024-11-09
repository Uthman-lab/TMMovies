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
    var cancellables = Set<AnyCancellable>()
    func getMovies(genre: Genre) throws -> AnyPublisher<MovieResponse, Error> {
        let request = try createRequest(genre: genre)
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: MovieResponse.self, decoder: JSONDecoder())
            .mapError { error in
                return error
            }
            .eraseToAnyPublisher()
    }
    
    private func createRequest(_ page: Int = 1, genre: Genre) throws -> URLRequest {
        guard let urlWithParams = try createURLWithParameters(page, genre: genre).url
        else {
            throw CustomErrors.decode("Can't get url from components")
        }
        var request = URLRequest(url: urlWithParams)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer \(configurations.token)"
        ]
        return request
    }
    
    private func createURLWithParameters(
        _ page: Int,
        genre: Genre
    ) throws -> URLComponents {
        let url = try configurations.parseURL(path: "movie/\(genre.rawValue)")
        guard var components = URLComponents(
            url: url,
            resolvingAgainstBaseURL: true
        ) else {
            throw CustomErrors.decode("Can't construct url")
        }
        let queryItems = createParameters(1)
        components.queryItems = components.queryItems.map {
            $0 + queryItems
        } ?? queryItems
        return components
    }
    
    private func createParameters(_ page: Int) -> [URLQueryItem] {
        [
            URLQueryItem(name: "language", value: Locale.current.identifier),
            URLQueryItem(name: "\(page)", value: "1"),
        ]
    }
}

enum Genre: String {
    case popular = "popular"
    case upcoming = "upcoming"
    case topRated = "top_rated"
    case nowPlaying = "now_playing"
}
