//
//  HomeViewModel.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/9/24.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    @Published var mainMovies: [Movie] = []
    @Published var genreMovies: [Movie] = []
    @Published var selectedGenre: String? = Genre.allCases.first?.text
    init() {
        getMainMovies()
        getMoviesForGenre(genre: determineGenre(text: selectedGenre) ?? .nowPlaying)
    }
    
    private let service = APIService()
    private var cancellables = Set<AnyCancellable>()
    
    
    func setGenre(genre: Genre) {
        selectedGenre = genre.text
        getMoviesForGenre(genre: genre)
    }
    
    private func determineGenre(text: String?) -> Genre? {
        for genre in Genre.allCases {
            if genre.text == text {
                return genre
            }
        }
        return nil
    }
    private func getMainMovies() {
        do {
            try service.getMovies(genre: Genre.nowPlaying)
                .sink(
                    receiveCompletion: {_ in },
                    receiveValue: { [weak self] movieResults in
                        DispatchQueue.main.async {
                            self?.mainMovies = movieResults.results
                        }
                    })
                .store(in: &cancellables)
        } catch {
            
        }
    }
    
    private func getMoviesForGenre(genre: Genre) {
        do {
            genreMovies = []
            try service.getMovies(genre: genre)
                .sink(
                    receiveCompletion: {_ in },
                    receiveValue: { [weak self] movieResults in
                        DispatchQueue.main.async {
                            self?.genreMovies = movieResults.results
                        }
                    })
                .store(in: &cancellables)
        } catch {
            print("error is \(error)")
        }
        }
}
