//
//  ImageWithNum.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/9/24.
//

import SwiftUI

struct ImageWithNum: View {
    let imageData: (url: URL?, num: Int)
    var body: some View {
        ZStack {
            RoundedImage(url: imageData.url)
                .frame(width: 144, height: 210)
            ImageNumber(number: imageData.num)
                .offset(.init(width: -60, height: 85))
        }
        .padding(.bottom, 20)
    }
}

#Preview {
    ImageWithNum(imageData: (url: URL(string: ""), num: 1))
}
