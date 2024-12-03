//
//  AnalyticsService.swift
//  TMMovies
//
//  Created by AMALITECH-PC-593 on 12/3/24.
//

import Foundation
import Firebase
import FirebaseAnalytics

final class AnalyticsService {
    private init() { }
    static let shared = AnalyticsService()
    
    func startFirebaseServices() {
        FirebaseApp.configure()
    }
    
    func sendNoSearchFound(word: String) {
        Analytics.logEvent("failed_search", parameters: [
            AnalyticsParameterSearchTerm: "test_query",
            "search_result": "no_results"
        ])
    }
}
