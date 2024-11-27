//
//  CastAvatar.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/11/24.
//

import SwiftUI
import Kingfisher

struct CastsView: View {
    let castMembers: [CastMember]
    @State var castMember: CastMember?
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [
                GridItem(.flexible(), alignment: .leading),
                GridItem(.flexible(), alignment: .leading)
            ]) {
                ForEach(castMembers.indices, id: \.self) { index in
                    CastAvatar(
                        castMember: castMembers[index],
                        index: index,
                        total: castMembers.count
                    )
                }
            }
        }
    }
}

struct CastAvatar: View {
    let castMember: CastMember
    let index: Int
    let total: Int
    @State var showDetails = false

    var body: some View {
        Button(action: {
            withAnimation {
                showDetails.toggle()
            }
        }) {
            VStack(alignment: .leading) {
                KFImage(castMember.avatarImage)
                    .placeholder {
                        Color.black
                    }
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 100, height: 100)
                    .accessibilityLabel(Text("Image of \(castMember.name) \(index + 1) of \(total)"))

                VStack(alignment: .leading) {
                    CastTile(label: "Name", value: castMember.name)
                    
                    if showDetails {
                        CastTile(label: "Character", value: castMember.character)
                        CastTile(label: "Known For", value: castMember.knownForDepartment)
                        CastTile(label: "Gender", value: castMember.gender.gendar)
                        CastTile(label: "Adult Actor", value: castMember.adult ? "Yes" : "No")
                    }
                }
                
            }
        }
        .accessibilityHint("Double-tap to \(showDetails ? "hide" : "view") details")
    }
}


struct CastTile: View {
    let label: String
    let value: String
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text(label)
                    .foregroundStyle(.secondaryText)
                Spacer()
                Text(value)
                    .foregroundStyle(.primaryText)
                Spacer()
            }
            .customFont(.medium, size: 10)
            .lineLimit(4)
            .multilineTextAlignment(.leading)
            Divider()
        }
        .frame(width: 100)
    }
}

extension Int? {
    var gendar: String {
        switch self {
        case 1:
            "Female"
        case 2:
            "Male"
        default:
            "Not known"
        }
    }
}

#Preview {
    CastsView(castMembers: CastMember.dummyData)
}
