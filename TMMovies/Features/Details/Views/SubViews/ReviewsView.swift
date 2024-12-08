//
//  ReviewCard.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/11/24.
//

import SwiftUI
import Kingfisher

struct ReviewsView: View {
    let reviews: [MovieReview]

    var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                ForEach(reviews) { review in
                    ReviewCard(review: review)
                }
            }
        }
    }
}

struct ReviewCard: View {
    let review: MovieReview
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            VStack {
                KFImage(review.avartarURL)
                    .placeholder({
                        Color.red
                    })
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(.circle)
                    .frame(width: 44, height: 44)

                Text("\(review.authorDetails.rating)")
                    .customFont(.medium, size: 12)
                    .foregroundStyle(.blue)
            }
            .accessibilityElement()
            .accessibilityLabel(
                Text(
                    "Image of \(review.authorDetails.username) \n" +
                    "Rating of \(review.authorDetails.username) is \(review.authorDetails.rating)"
                )
            )
            VStack(alignment: .leading) {
                Text("A review by \(review.authorDetails.username)")
                    .customFont(.medium, size: 12)
                    .foregroundStyle(.primaryText)
                Text(review.content)
                    .customFont(.regular, size: 12)
                    .foregroundStyle(.primaryText)
            }
            Spacer()
        }
    }
}

#Preview {
    ZStack {
        Color.black
        ReviewsView(reviews: [
            MovieReview.dummyReview,
            MovieReview.dummyReview
        ])
    }
}
