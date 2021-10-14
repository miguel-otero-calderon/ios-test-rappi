//
//  MovieTopRatedResponse.swift
//  ios-test-rappi
//
//  Created by Miguel on 14/10/21.
//

import Foundation

struct MovieTopRatedResponse: Codable {
    let page: Int
    let results: [MovieData]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
