//
//  SearchTextField.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/9/24.
//

import SwiftUI

struct SearchTextField: View {
    @Binding var text: String
    var action: () -> Void = {}
    
    var body: some View {
        HStack {
            TextField(text: $text) {
                Text("Search".lowercased())
                    .foregroundStyle(Color(.primaryText))
            }
            .accessibilityLabel(Text("Search Field"))
            .accessibilityHint(Text("Enter text to search"))
            .foregroundStyle(Color(.primaryText))
            .onChange(of: text) {
                    action()
                }
            Image("searchIcon")
                .accessibilityHidden(true)
        }
        .foregroundColor(Color(.primaryText))
        .frame(height: 42)
        .padding(.leading, 25)
        .padding(.trailing, 15)
        .background(Color(.searchField))
        .clipShape(.rect(cornerRadius: 16))
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    SearchTextField(text: .constant(""))
}
