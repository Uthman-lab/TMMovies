//
//  LoadingView.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/16/24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            Spacer()
            ProgressView()
                .tint(.rating)
            Spacer()
        }
    }
}

#Preview {
    LoadingView()
}
