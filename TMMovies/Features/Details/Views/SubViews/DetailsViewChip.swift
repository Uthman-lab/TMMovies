//
//  DetailsPageChip.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/10/24.
//

import SwiftUI

struct DetailsViewChip: View {
    let iconName: ImageResource
    let label: String
    var body: some View {
        HStack(alignment: .center) {
            Image(iconName)
            Text(label)
        }
        .foregroundStyle(Color(.secondaryText))
        .customFont(.medium, size: 12)
        .accessibilityElement(children: .ignore)
    }
}

#Preview {
    DetailsViewChip(iconName: .actionIcon, label: "action")
}
