//
//  ProfileCard.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/21/24.
//

import SwiftUI

struct ProfileCard: View {
    var imageString: String
    var action: () -> Void = {}
    var title: String

    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: imageString)
                    .customFont(.medium, size: 30)
                Text(title)
                    .customFont(.semiBold, size: 16)
                Spacer()
                Image(systemName: "chevron.right")
            }
            .padding(.horizontal, 28)
            .padding(.vertical, 16)
            .foregroundStyle(.primaryText)
            .background()
            .clipShape(.rect(cornerRadius: 20))
            .shadow(
                color: .black.opacity(0.1),
                radius: 20)
        }
    }
}

#Preview {
    ProfileCard(imageString: "sun.max", title: "Light")
}
