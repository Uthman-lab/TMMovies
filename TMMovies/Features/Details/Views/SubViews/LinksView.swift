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
            VStack(alignment: .leading) {
                Text("Get movie here")
                    .customFont(.regular, size: 12)
                    .foregroundStyle(.primaryText)
                HStack {
                    LinkIcon(
                        source: .system(name: "globe"),
                        urlToOpen: movieDetails?.homePageURL
                    )
                    .accessibilityLabel(Text("Go to movie site Link"))
                    LinkIcon(
                        source: .asset(name: .imdbIcon),
                        urlToOpen: movieDetails?.imdbURL
                    )
                    .accessibilityLabel(Text("Go to IMDB site Link"))
                }
            }
            .padding()
            .background(.rating)
            .clipShape(.rect(cornerRadius: 8))
            Spacer()
        }
    }
}

struct LinkIcon: View {
    let source: ImageSource
    @State var showSafariView = false
    var urlToOpen: URL?
    
    var body: some View {
        Button(action: {
            showSafariView = true
        }) {
            switch source {
            case .system(let name):
                Image(systemName: name)
                    .padding(12)
                    .background(.card)
                   
            case .asset(let name):
                Image(name)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        .clipShape(.rect(cornerRadius: 8))
        .frame(minHeight: 40, maxHeight: 40)
        .accessibilityElement()
        .sheet(isPresented: $showSafariView) {
            if let url = urlToOpen {
                WebView(url: url)
            }
        }
    }
}

 enum ImageSource {
    case system(name: String)
    case asset(name: ImageResource)
}

#Preview {
    LinksView(movieDetails: .constant(MovieDetails.dummyMovie))
}
