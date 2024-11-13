//
//  ImageNumbers.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/9/24.
//

import SwiftUI

struct ImageNumber: View {
    let number: Int
    var body: some View {
        ZStack(alignment: .center) {
           Text(String(number))
                .customFont(.semiBold, size: 96)
                .foregroundStyle(Color(.background))
                .shadow(
                    color: .blue, radius: 3
                    )
        }

    }
}

#Preview {
    ImageNumber(number: 1)
}
