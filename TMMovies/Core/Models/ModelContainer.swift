//
//  ModelContainer.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 11/19/24.
//

import Foundation
import SwiftData

@MainActor
var container: ModelContainer = {
    do {
        var config = ModelConfiguration()
        config.schema =  Schema([MovieStorageModel.self])
        return try ModelContainer(
            for: MovieStorageModel.self,
            configurations: config
        )
    } catch {
        fatalError("can't load movies from swiftdata storage")
    }
}()
