//
//  PageWithBackground.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/9/24.
//

import SwiftUI

struct PageWithBackground<Content: View>: View {
  
    let content: () -> Content
    var body: some View {
        ZStack(alignment: .leading) {
            Color(.background)
                .ignoresSafeArea(edges: .all)
            content()
               // .padding(.top, 23)
        }
    }
}

#Preview {
    PageWithBackground {
        EmptyView()
    }
}
