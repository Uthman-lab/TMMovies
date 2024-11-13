//
//  ReviewModel.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/11/24.
//

import Foundation

// MARK: - MovieReviewResponse
struct MovieReviewResponse: Codable {
    let id: Int
    let page: Int
    let results: [MovieReview]
    let totalPages: Int
    let totalResults: Int

    enum CodingKeys: String, CodingKey {
        case id
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - MovieReview
struct MovieReview: Codable, Identifiable {
    let author: String
    let authorDetails: AuthorDetails
    let content: String
    let createdAt: String
    let id: String
    let updatedAt: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case author
        case authorDetails = "author_details"
        case content
        case createdAt = "created_at"
        case id
        case updatedAt = "updated_at"
        case url
    }
}

// MARK: - AuthorDetails
struct AuthorDetails: Codable {
    let name: String
    let username: String
    let avatarPath: String?
    let rating: Int

    enum CodingKeys: String, CodingKey {
        case name
        case username
        case avatarPath = "avatar_path"
        case rating
    }
}

extension MovieReview {
    var avartarURL: URL? {
        APIConfiguration.main.parseImageURL(path: self.authorDetails.avatarPath ?? "")
    }
    
   static var dummyReview: MovieReview {
        MovieReview(
            author: "CinemaSerf",
            authorDetails:
                AuthorDetails(
                    name: "CinemaSerf",
                    username: "Geronimo1967",
                    avatarPath: Optional("/yz2HPme8NPLne0mM8tBnZ5ZWJzf.jpg"),
                    rating: 7
                ),
            content: "This maybe hit the cinemas a month too early as there\'s a distinctly festive feel to this latest outing for the menacing \"Art\" the clown. He descends upon the townsfolk with blood-thirsty enthusiasm causing some brutal carnage but then he and his equally heinous pal \"Vicky\" (Samantha Scaffidi) go for a long nap. It\'s a pair of unfortunate demolition guys who provide their wake up entertainment and rejuvenated, they set out in search of \"Sienna\" (Lauren LaVera) and brother \"Jonathan\" (Elliott Fulham) - and woe betides anyone who gets in the way - even if you are dressed as Santa Claus. This is by far the best of the three so far, I think. There\'s much less repetition with the standard slashing-fayre and a bit more, dare I say, intimacy from our \"Terrifier\" as David Howard Thornton imbues his character with more akin to an emotional and quirky mime artist. There\'s more sadness, mischief and playfulness as he wields everything from an axe to a chain-saw. Shower sex might never be the same again! It\'s really the last half hour that gets it moving and though that scenario is largely predictable and I have to say that none of the speaking-part acting here is really very good, the tension mounts nicely and there\'s an entertaining degree of shock mixed with dark humour and Christmas gifts to raise a smile and maybe the one hair on the back of your neck towards the denouement. Sure, it\'s formulaic and there aren\'t so many surprises, but they are getting better and moving away from the Hammer style of ketchup gore and annoying, hysterical, frat-style characters that we\'ve seen before. It\'s entirely forgettable, and far too long, but I did quite enjoy it.",
            createdAt: "2024-10-14T05:01:31.886Z",
            id: "670ca5ab4111be4f0274fbf4",
            updatedAt: "2024-10-16T09:00:20.637Z",
            url: "https://www.themoviedb.org/review/670ca5ab4111be4f0274fbf4")
    }
}

