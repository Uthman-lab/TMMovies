//
//  APIConfiguration.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/9/24.
//

import Foundation

final class APIConfiguration {

    // MARK: Life cycle methods

    private init() {
        bundle = Bundle.main
    }

    ///  Constructor used for unit testing
    ///
    /// This constructor is essential for unit testing as it allows us to
    ///  fully create our dependencies
     init(bundle: Bundle) {
        self.bundle = bundle
    }

    private let bundle: Bundle

    // MARK: public variables

    static let main = APIConfiguration()
    lazy var token: String = {
        fetchSecret(key: .token)
    }()

    // MARK: private variables

    private var baseURL: String {
        fetchURLString(key: .baseURL)
    }

    // MARK: public methods

    func parseURL(
        path: String
    ) throws -> URL {
        guard let url = URL(string: baseURL + path) else {
            throw CustomErrors.decode("Can't parse the url")
        }
        return url
    }
    
    func parseImageURL(path: String) -> URL? {
        guard let url = URL(string: fetchURLString(key: .imageURL) + path) else {
            return nil
        }
        return url
    }

    // MARK: private methods

    private func  fetchSecret(key: SecretKey) -> String {
        guard let secret: String = bundle.object(
            forInfoDictionaryKey: key.rawValue
        ) as? String, !secret.isEmpty else {
            return ""
        }
        return secret
    }
    
    private func fetchURLString(key: SecretKey) -> String {
        "https://\(fetchSecret(key: key))"
    }
}

enum SecretKey: String {
    case baseURL = "BASE_URL"
    case imageURL = "ImageURL"
    case token = "TOKEN"
}
