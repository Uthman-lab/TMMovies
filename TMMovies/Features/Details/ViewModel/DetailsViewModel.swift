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
        getMovieDetails()
        getReviews()
        getCastMembers()
        getVideos()
    }

    // MARK: - private variables

    private let apiService = APIService()
    private let movie: Movie
    var cancellables = Set<AnyCancellable>()

    // MARK: - public variables

    @Published var reviews: [MovieReview] = []
    @Published var castMembers: [CastMember] = []
    @Published var movieDetails: MovieDetails?
    @Published var videos: [MovieVideo] = []

    // MARK: - public methods
    
    func getMovieDetails() {
        apiService.getMovieDetails(id: movie.id)
            .sink(receiveCompletion: { s in print("error is \(s)")}, receiveValue: { [weak self] movieResult in
                DispatchQueue.main.async {
                    print("movie is \(movieResult)")
                    self?.movieDetails = movieResult
                }
            })
            .store(in: &cancellables)
    }

    func getReviews() {
        apiService.getReviews(movie: movie)
            .sink(receiveCompletion: { _ in}, receiveValue: { [weak self] reviewResults in
                DispatchQueue.main.async {
                    self?.reviews = reviewResults.results
                }
            })
            .store(in: &cancellables)
    }

    func getCastMembers() {
        apiService.getCasts(movie: movie)
            .sink(receiveCompletion: { completion in
                print(completion)
            }, receiveValue: { [weak self] castResult in
                DispatchQueue.main.async {
                    self?.castMembers = castResult.cast
                }
            })
            .store(in: &cancellables)
    }
    
    func getVideos() {
        apiService.getVideosForMovie(movieId: movie.id)
            .sink(receiveCompletion: { completion in
                print(completion)
            }, receiveValue: { [weak self] videoResults in
                DispatchQueue.main.async {
                    debugPrint("videos are \(videoResults.results)")
                    self?.videos = videoResults.results
                }
            })
            .store(in: &cancellables)
    }
}
