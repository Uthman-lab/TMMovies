//
//  TrailingNavIcon.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/19/24.
//

import SwiftUI

struct TrailingNavIcon: View {
    let icon: ImageResource
    let onTap: () -> Void
    var body: some View {
        Button(action: onTap) {
            Image(icon)
                .renderingMode(.template)
                .customFont(.normal, size: 16)
                .foregroundStyle(.primaryText)
        }
        .accessibilityElement(children: .combine)
    }
}

struct TrailingNavIconModifier: ViewModifier {
    let icon: ImageResource
    let placement: ToolbarItemPlacement
    var accessibilityLabel: String
    let onTap: () -> Void
    func body(content: Content) -> some View {
        content
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: placement) {
                    TrailingNavIcon(
                        icon: icon,
                        onTap: onTap
                    )
                    .accessibilityLabel(Text(accessibilityLabel))
                }
            }
    }
}

extension View {
    func useTrailingNavbarView(
        _ icon: ImageResource,
        accessibilityLabel: String = "",
        onTap: @escaping () -> Void = {},
        placement: ToolbarItemPlacement = .topBarTrailing
    ) -> some View {
        self.modifier(
                TrailingNavIconModifier(
                    icon: icon,
                    placement: placement,
                    accessibilityLabel: accessibilityLabel,
                    onTap: onTap
                )
            )
    }
}
#Preview {
    NavbarTitle(title: "Hello there")
}
