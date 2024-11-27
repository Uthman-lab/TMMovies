//
//  TabSections.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/22/24.
//

import SwiftUI

struct TabSection: View {
    @Binding var selectedSection: String?
    let sections: [String]
    var body: some View {
        HStack(alignment: .top, spacing: 24) {
            ForEach(sections.indices, id: \.self) { index in
                TextTabItem(
                    text: sections[index],
                    selectedTab: $selectedSection,
                    action: {
                        selectedSection = sections[index]
                    })
                .accessibilityLabel(Text("\(sections[index]) Tab"))
            }
        }
    }
}


#Preview {
    TabSection(
        selectedSection: .constant("hello"),
        sections: [
            "hello", "There", "come here"
        ])
}
