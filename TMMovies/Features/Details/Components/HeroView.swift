//
//  HeroView.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/9/24.
//

import SwiftUI
import Kingfisher

struct HeroView: View {
    let posterImage: URL?
    let image: URL?
    let movieTitle: String
    let bounds = UIScreen.main.bounds
    var body: some View {
        ZStack {
            KFImage(image)
                .placeholder {
                    Color.red
                }
                .resizable()
                .frame(height: 210)
            RoundedImage(
                url: posterImage
            )
                .frame(width: 95, height: 120)
                .offset(
                    .init(
                        width: -120,
                        height: 100
                    )
                )
            Text(movieTitle)
                .multilineTextAlignment(.leading)
                .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
                .frame(
                    width:  bounds.width * 0.62,
                    height: 60, alignment: .topLeading
                )
                .foregroundStyle(Color(.primaryText))
                .customFont(.semiBold)
                .offset(
                    .init(
                        width: 60,
                        height: 145)
                )
        }
        .padding(.bottom, 56)
    }
}

#Preview {
    ZStack {
        Color.blue
        HeroView(
            posterImage: nil,
            image: nil,
            movieTitle: "Spiderman No wsdfsfasay home"
        )
    }
}

