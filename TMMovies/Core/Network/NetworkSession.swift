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

    func getRequest<T: Codable>(
        path: String,
        queryParameters: [URLQueryItem] = [],
        addParameters: Bool = true
    ) -> AnyPublisher<T, Error> {
       guard let request = try? createRequest(
            path: path,
            queryParameters: queryParameters
       ) else {
           return Fail(
            error: CustomErrors.decode("can't parse url")
           )
           .eraseToAnyPublisher()
       }
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { result in
              return  result.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                return error
            }
            .eraseToAnyPublisher()
    }

    private func createRequest(
        path: String,
        queryParameters: [URLQueryItem]
    ) throws -> URLRequest {
        guard let urlWithParams = try createURLWithParameters(
            path: path,
            queryParameters: queryParameters
        ).url else {
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
        path: String,
        queryParameters: [URLQueryItem] = []
    ) throws -> URLComponents {
        let url = try configurations.parseURL(path: "\(path)")
        guard var components = URLComponents(
            url: url,
            resolvingAgainstBaseURL: true
        ) else {
            throw CustomErrors.decode("Can't construct url")
        }

        // Add query parameters if they exist
        components.queryItems = (components.queryItems ?? []) + queryParameters

        return components
    }

}
