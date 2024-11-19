//
//  Debouncer.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/15/24.
//

import Foundation
import Combine

class Debouncer<T: Equatable> {

    // MARK: - private variables

    private var cancelables = Set<AnyCancellable>()
    private var subject: PassthroughSubject<T, Never>?

    // MARK: - public methods

    func debounce(value: T, action: @escaping (T) -> Void) {
        guard let _ = subject else {
            initialize(action: action)
            sendValue(value: value)
            return
        }
        sendValue(value: value)

    }

    // MARK: - private methods

   private func sendValue(value: T) {
        subject?.send(value)
    }

    private func initialize(action: @escaping (T) -> Void) {
        subject =  PassthroughSubject<T, Never>()
        subject?.debounce(
            for: .milliseconds(600),
            scheduler: RunLoop.main
        )
        .removeDuplicates(by: {$0 == $1})
        .sink(
            receiveCompletion: { _ in

            },
            receiveValue: { value in
                action(value)
            })
        .store(in: &cancelables)
    }
}
