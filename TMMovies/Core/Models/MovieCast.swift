//
//  MovieCast.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/11/24.
//

import Foundation

struct CastResponse: Codable {
    let id: Int
    let cast: [CastMember]
}

struct CastMember: Codable, Identifiable, Hashable {
    let adult: Bool
       let gender: Int?
       let id: Int
       let knownForDepartment: String
       let name: String
       let originalName: String
       let popularity: Double
       let profilePath: String?
       let castID: Int
       let character: String
       let creditID: String
       let order: Int

       enum CodingKeys: String, CodingKey {
           case adult
           case gender
           case id
           case knownForDepartment = "known_for_department"
           case name
           case originalName = "original_name"
           case popularity
           case profilePath = "profile_path"
           case castID = "cast_id"
           case character
           case creditID = "credit_id"
           case order
       }
}

extension CastMember {
    var avatarImage: URL? {
        APIConfiguration.main.parseImageURL(path: self.profilePath ?? "")
    }

    static var dummyData: [CastMember] {
        [
            CastMember(
                adult: false,
                gender: 2,
                id: 67890,
                knownForDepartment: "Acting",
                name: "Daniel Radcliffe",
                originalName: "Daniel Jacob Radcliffe",
                popularity: 90.5,
                profilePath: "/path_to_daniel_radcliffe_profile.jpg",
                castID: 2,
                character: "Harry Potter",
                creditID: "efgh5678",
                order: 1
            ),
            CastMember(
                adult: false,
                gender: 2,
                id: 11223,
                knownForDepartment: "Acting",
                name: "Rupert Grint",
                originalName: "Rupert Alexander Lloyd Grint",
                popularity: 70.3,
                profilePath: "/path_to_rupert_grint_profile.jpg",
                castID: 3,
                character: "Ron Weasley",
                creditID: "ijkl91011",
                order: 2
            ),
            CastMember(
                adult: false,
                gender: 1,
                id: 12345,
                knownForDepartment: "Acting",
                name: "Emma Watson",
                originalName: "Emma Charlotte Duerre Watson",
                popularity: 85.2,
                profilePath: "/path_to_emma_watson_profile.jpg",
                castID: 1,
                character: "Belle",
                creditID: "abcd1234",
                order: 0
            )
        ]
    }
}
