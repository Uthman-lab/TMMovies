//
//  TextTabItem.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/9/24.
//

import SwiftUI

struct TextTabItem: View {
    let text: String
    @Binding var selectedText: String?
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
                if selectedText == text {
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
    }
}

#Preview {
    TextTabItem(
        text: "Hello",
        selectedText: .constant("Hello"),
        action: {}
    )
}
