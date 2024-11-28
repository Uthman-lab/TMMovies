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
    @ScaledMetric var iconSize = 12
    var body: some View {
        HStack(alignment: .center) {
            Image(iconName)
                .resizable()
                .frame(width: iconSize, height: iconSize)
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
