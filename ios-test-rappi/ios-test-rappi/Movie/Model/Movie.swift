//
//  Movie.swift
//  ios-test-rappi
//
//  Created by Miguel on 14/10/21.
//

import Foundation
import UIKit

struct Movie {
    let adult: Bool
    var backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let originalLanguage, originalTitle, overview: String
    let popularity: Double
    var posterPath: String
    let releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    let movieType: MovieType
    
    var backdropImage: UIImage?
    var posterImage: UIImage?
    
    init(movieData: MovieData, movieType:MovieType) {
        self.adult = movieData.adult
        self.genreIDS = movieData.genreIDS
        self.id = movieData.id
        self.originalLanguage = movieData.originalLanguage
        self.originalTitle = movieData.originalTitle
        self.overview = movieData.overview
        self.popularity = movieData.popularity
        self.releaseDate = movieData.releaseDate
        self.title = movieData.title
        self.video = movieData.video
        self.voteAverage = movieData.voteAverage
        self.voteCount = movieData.voteCount
        self.movieType = movieType
        self.backdropPath = ""
        self.posterPath = ""
        self.backdropImage = nil
        self.posterImage = nil
    }
}
extension Movie {
    var idBackdropPath: NSString {
        "\(id)/backdrop_path" as NSString
    }
    var idPosterPath: NSString {
        "\(id)/poster_path" as NSString
    }
}
