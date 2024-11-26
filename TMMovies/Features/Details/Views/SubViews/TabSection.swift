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
            ForEach(sections, id: \.self) { section in
                TextTabItem(
                    text: section,
                    selectedTab: $selectedSection,
                    action: {
                        selectedSection = section
                    })
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
