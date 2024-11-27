//
//  TextTabItems.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/22/24.
//

import SwiftUI

struct TextTabItem: View {
    let text: String
    @Binding var selectedTab: String?
    var action: () -> Void

    var body: some View {
        Button(action: {
            withAnimation {
                action()
            }
        }) {
            VStack(spacing: 4) {
                Text(text)
                    .customFont(.medium, size: 14)
                    .foregroundStyle(Color(.primaryText))
                if selectedTab == text {
                    Text(text)
                        .customFont(.medium, size: 14)
                        .foregroundStyle(.clear)
                        .frame(height: 4)
                        .background(
                            Rectangle()
                                .foregroundStyle(Color(.secondaryIcon))
                        )
                }
            }
        }
        .accessibilityElement(children: .combine)
    }
}


#Preview {
    TextTabItem(text: "Hello", selectedTab: .constant("Hello"), action: {})
}
