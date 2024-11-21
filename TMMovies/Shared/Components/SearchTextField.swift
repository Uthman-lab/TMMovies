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
                Text("Search")
                    .foregroundStyle(Color(.primaryText))
            }
            .onChange(of: text) {
                action()
            }
            Image("searchIcon")
        }
        .foregroundColor(Color(.primaryText))
        .frame(height: 42)
        .padding(.leading, 25)
        .padding(.trailing, 15)
        .background(Color(.searchField))
        .clipShape(.rect(cornerRadius: 16))
    }
}

#Preview {
    SearchTextField(text: .constant("sdfadfae"))
}
