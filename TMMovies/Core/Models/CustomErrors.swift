//
//  File.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/9/24.
//

import Foundation

enum CustomErrors: Error {
    case errorLoadingFile
    case decode(_ message: String)
    case fakeTestingError

}

extension CustomErrors: LocalizedError {

    var errorDescription: String? {
        switch self {
        case .errorLoadingFile:
            return "Error loading file."
        case .decode(let message):
            return "Decoding error: \(message)"
        case .fakeTestingError:
            return "Fake testing error."
        }
    }

    var failureReason: String? {
        switch self {
        case .errorLoadingFile:
            return "The file could not be loaded from the specified location."
        case .decode:
            return "The data could not be decoded into the expected format."
        case .fakeTestingError:
            return "This is a simulated error for testing purposes."
        }
    }

    var recoverySuggestion: String? {
        switch self {
        case .errorLoadingFile:
            return "Check the file path and ensure the file exists."
        case .decode:
            return "Verify the data format and ensure it matches the expected structure."
        case .fakeTestingError:
            return "This error is intended for testing. No recovery action is required."
        }
    }
}
