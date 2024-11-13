//
//  CastAvatar.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/11/24.
//

import SwiftUI
import Kingfisher

struct CastAvatar: View {
    let url: URL?
    let name: String
    var body: some View {
        VStack {
            KFImage(url)
                .placeholder {
                    Color.black
                }
                .resizable()
                .scaledToFill()
                .clipShape(.circle)
                .frame(width: 100, height: 100)
            Text(name)
                .customFont(.medium, size: 12)
                .foregroundStyle(.primaryText)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .frame(width: 100)
        }
    }
}

#Preview {
    CastAvatar(url: nil, name: "Benedict Cumberbatch")
}
