//
//  LinksView.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/22/24.
//

import SwiftUI

struct LinksView: View {
    @Binding var movieDetails: MovieDetails?
    var body: some View {
        HStack {
            LinkIcon(
                content: {
                    Image(systemName: "globe")
                        .customFont(.semiBold)
                },
                urlToOpen: movieDetails?.homePageURL
            )
            LinkIcon(
                content:{
                    Text("IMDb")
                        .customFont(.semiBold)
                        .foregroundStyle(.primaryText)
                },
                urlToOpen: movieDetails?.imdbURL
            )
        }
    }
}

struct LinkIcon<Content: View>: View {
    let content: () -> Content
    @State var showSafariView = false
    var urlToOpen: URL?
    
    var body: some View {
        Button(action: {
            showSafariView = true
        }) {
            content()
        }
        .padding(8)
        .background(.card)
        .clipShape(.rect(cornerRadius: 8))
        .sheet(isPresented: $showSafariView) {
            if let url = urlToOpen {
                WebView(url: url)
            }
        }
    }
}

#Preview {
    LinksView(movieDetails: .constant(MovieDetails.dummyMovie))
}
