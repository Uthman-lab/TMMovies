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
    var body: some View {
        KFImage(url)
            .placeholder({
                ZStack(alignment: .center) {
                    Color.black
                    LoadingView()
                }
            })
            .resizable()
            .clipShape(.rect(cornerRadius: 16))
    }
}

#Preview {
    RoundedImage(url: APIConfiguration.main.parseImageURL(path: "/hhiR6uUbTYYvKoACkdAIQPS5c6f.jpg"))
}
