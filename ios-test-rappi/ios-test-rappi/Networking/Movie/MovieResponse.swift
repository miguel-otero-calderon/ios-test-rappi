//
//  MovieUpCommingResponse.swift
//  ios-test-rappi
//
//  Created by Miguel on 14/10/21.
//

import Foundation

struct MovieResponse: Codable {
    let dates: MovieDates?
    let page: Int
    let results: [MovieData]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct MovieDates: Codable {
    let maximum, minimum: String
}
