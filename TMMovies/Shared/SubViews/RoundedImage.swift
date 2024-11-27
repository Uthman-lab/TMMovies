//
//  RoundedImage.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/9/24.
//

import SwiftUI
import Kingfisher

struct RoundedImage: View {
    let url: URL?
    var isVideo = false
    var body: some View {
        ZStack {
            KFImage(url)
                .placeholder({
                    ZStack(alignment: .center) {
                        Color.black
                        LoadingView()
                    }
                })
                .resizable()
                .clipShape(.rect(cornerRadius: 16))
            if isVideo {
                Image(systemName: "play.circle.fill")
                    .foregroundStyle(.white)
                    .customFont(.medium, size: 50)
            }
        }
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    RoundedImage(url: APIConfiguration.main.parseImageURL(path: "/hhiR6uUbTYYvKoACkdAIQPS5c6f.jpg"))
        .frame(width: 400, height: 300)
}
