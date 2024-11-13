//
//  NetworkSession.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/11/24.
//

import Foundation
import Combine

final class NetworkSession {
    let configurations = APIConfiguration.main
    var cancellables = Set<AnyCancellable>()
    
    func getRequest<T: Codable>(path: String) throws -> AnyPublisher<T, Error> {
        let request = try createRequest(path: path)
        print(request.url)
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                return error
            }
            .eraseToAnyPublisher()
    }
    
    private func createRequest(path: String) throws -> URLRequest {
        guard let urlWithParams = try createURLWithParameters(path: path).url
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
        _ page: Int = 1,
        path: String
    ) throws -> URLComponents {
        let url = try configurations.parseURL(path: "movie/\(path)")
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
            URLQueryItem(name: "page", value: "\(page)"),
        ]
    }
}
