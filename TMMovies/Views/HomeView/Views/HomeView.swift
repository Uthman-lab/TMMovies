//
//  HomeView.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/9/24.
//

import SwiftUI

struct HomeView: View {
    @State var text = ""
    @StateObject var viewModel = HomeViewModel()
    var body: some View {
        PageWithBackground {
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    Text("What do you want to watch?")
                        .foregroundStyle(Color(.primaryText))
                        .customFont(.semiBold)
                    SearchTextField(text: $text)
                    MainMovies(movies: viewModel.mainMovies)
                    TabSection(
                        selectedGenre: $viewModel.selectedGenre,
                        homeViewModel: viewModel
                    )
                    TabBarMovies(movies: $viewModel.genreMovies)
                }
            }
            .padding(.horizontal, 24)
        }
    }
}

struct MainMovies: View {
    let movies: [Movie]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 30) {
                if movies.isEmpty {
                    ForEach(1..<5) { index in
                        ImageWithNum(
                            imageData: (URL(string: ""), index)
                        )
                    }
                } else {
                    ForEach(Array(movies.enumerated()), id: \.offset) { index, movie in
                        ImageWithNum(
                            imageData: (movie.posterImage, index + 1)
                        )
                    }
                }
            }
        }
        .padding(.bottom, 32)
    }
}

struct TabSection: View {
    @Binding var selectedGenre: Genre?
    @ObservedObject var homeViewModel: HomeViewModel
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 30) {
                ForEach(Genre.allCases, id: \.rawValue) { genre in
                    TextTabItem(
                        genre: genre,
                        viewModel: homeViewModel
                    )
                }
            }
        }
    }
}
struct TabBarMovies: View {
    @Binding var movies: [Movie]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: formGrid(), alignment: .leading, content: {
                if movies.isEmpty {
                    ForEach(1..<5) {
                        _ in
                        RoundedImage(url: nil)
                            .frame(height: 145)
                    }
                } else {
                    ForEach(Array(movies.enumerated()), id: \.offset) {
                        (index, movie) in
                        RoundedImage(url: movie.posterImage)
                            .frame(height: 145)
                    }
                }
            })
        }
        .frame(height: 400)
    }
    
    func formGrid() -> [GridItem] {
        let bounds = UIScreen.main.bounds
        var griditems: [GridItem] = []
        for _ in 1...3 {
            let item = GridItem(
                .flexible(
                    minimum: bounds.width * 0.28,
                    maximum: bounds.width * 0.28
                ), spacing: 16
            )
            griditems.append(item)
        }
        return griditems
    }
}

#Preview {
    HomeView()
}
