//
//  WishListView.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/19/24.
//

import SwiftUI

struct WishListView: View {
    @ObservedObject var wishViewModel = WishViewModel.shared
    
    var body: some View {
        NavigationStack {
            PageWithBackground {
                    VStack {
                        if wishViewModel.wishList.isEmpty {
                            HStack {
                                Spacer()
                                Image(.noResultsIcon)
                                Spacer()
                            }
                        } else {
                            ScrollView {
                            LazyVStack(alignment: .leading, spacing: 24) {
                                ForEach(wishViewModel.wishList) { movie in
                                    NavigationLink(destination: {
                                        DetailsView(movie: movie)
                                    }, label: {
                                        MovieCard(movie: movie)
                                    })
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom)
            }
            .customTitle("Watch list")
        }
    }
}

#Preview {
    WishListView()
}
