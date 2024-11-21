//
//  CustomTitle.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/19/24.
//

import SwiftUI

struct NavbarTitle: View {
    let title: String
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        Text(title)
            .customFont(.normal, size: 16)
            .foregroundStyle(.primaryText)
            .bold()
    }
}

struct NavbarTitleModifier: ViewModifier {
    let title: String
    let isBold: Bool
    let placement: ToolbarItemPlacement
    func body(content: Content) -> some View {
        content
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: placement) {
                    if isBold {
                        NavbarTitle(title: title)
                            .bold()
                    } else {
                        NavbarTitle(title: title)
                    }
                }
            }
    }
}

extension View {
    func customTitle(
        _ title: String,
        isBold: Bool = true,
        placement: ToolbarItemPlacement = .principal
    ) -> some View {
        self
            .modifier(
                NavbarTitleModifier(
                    title: title,
                    isBold: isBold,
                    placement: placement
                )
            )
    }
}

#Preview {
    NavbarTitle(title: "@Telecom")
}
