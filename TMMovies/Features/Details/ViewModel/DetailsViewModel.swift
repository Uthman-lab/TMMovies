//
//  DetailsViewModel.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/11/24.
//

import Foundation
import Combine

class DetailsViewModel: ObservableObject {
    
    // MARK: - life cycle methods
    
    init(movie: Movie) {
        self.movie = movie
        getReviews()
        getCastMembers()
    }
    
    // MARK: - private variables
    
    private let apiService = APIService()
    private let movie: Movie
    var cancellables = Set<AnyCancellable>()
    
    // MARK: - public variables
    
    @Published var reviews: [MovieReview] = []
    @Published var castMembers: [CastMember] = []
    
    // MARK: - public methods
    
    func getReviews() {
        do {
            try apiService.getReviews(movie: movie)
                .sink(receiveCompletion: { _ in}, receiveValue: { [weak self] movieResult in
                    DispatchQueue.main.async {
                        self?.reviews = movieResult.results
                    }
                })
                .store(in: &cancellables)
        } catch {
            reviews = []
        }
    }
    
    func getCastMembers() {
        do {
            try apiService.getCasts(movie: movie)
                .sink(receiveCompletion: { completion in
                    print(completion)
                }, receiveValue: { [weak self] castResult in
                    print("data found")
                    DispatchQueue.main.async {
                        self?.castMembers = castResult.cast
                    }
                })
                .store(in: &cancellables)
        } catch {
            print("error is \(error)")
            castMembers = []
        }
    }
}
