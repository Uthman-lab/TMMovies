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

struct CastMember: Codable, Identifiable {
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
}
