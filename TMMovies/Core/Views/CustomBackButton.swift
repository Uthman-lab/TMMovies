//
//  CustomBackButton.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/19/24.
//


import SwiftUI

struct BackButton: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    var systemIcon: String = "chevron.left"
    var action: () -> Void = {}

    var body: some View {
        Button(action: {
            dismiss.callAsFunction()
            action()
        }, label: {
                HStack {
                    Image(systemName: systemIcon)
                        .customFont(.medium, size: 16)
                }
                .foregroundColor(.primaryText)
        })
    }
}

struct BackButtonModefier: ViewModifier {
    let placement: ToolbarItemPlacement
    let systemIcon: String
    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: placement) {
                    BackButton(systemIcon: systemIcon)
                }
            }
    }
}

extension View {
    func useCustomBackButton(
        placement: ToolbarItemPlacement = ToolbarItemPlacement.topBarLeading,
        systemIcon: String = "chevron.left"
    ) -> some View {
        self.modifier(
            BackButtonModefier(
                placement: placement,
                systemIcon: systemIcon
            )
        )
    }
}
#Preview {
    BackButton( systemIcon: "chevron.left")
}
