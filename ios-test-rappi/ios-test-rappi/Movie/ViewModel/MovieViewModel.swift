//
//  MovieViewModel.swift
//  ios-test-rappi
//
//  Created by Miguel on 14/10/21.
//

import Foundation
import UIKit

protocol MovieViewModelProtocol: AnyObject {
    func getMovies(movieType: MovieType)
    
    var delegate: MovieViewModelDelegate? {get set}
    var service: MovieServiceProtocol { get }
    var movies: [Movie] { get }
}

protocol MovieViewModelDelegate: AnyObject {
    func getMovies(movies: [Movie]?, error: Error?)
}

class MovieViewModel: MovieViewModelProtocol {
    
    var movies: [Movie]
    var service: MovieServiceProtocol
    var delegate: MovieViewModelDelegate?
    
    static let cacheImages = NSCache<NSString, UIImage>()
    private let urlImage = "https://image.tmdb.org/t/p/w500"

    init(service: MovieServiceProtocol) {
        self.service = service
        self.movies = []
    }
    
    func getMovies(movieType: MovieType) {
        let request = MovieRequest(movieType: movieType)
        self.service.getMovies(request: request) {[weak self] response, error in
            
            self?.movies = []
            
            if let error = error {
                self?.delegate?.getMovies(movies: nil, error: error)
                return
            }
                        
            if let movieResponse = response {
                for movieData in movieResponse.results {
                    
                    var movie = Movie(
                        movieData: movieData,
                        movieType: request.movieType)
                    
                    let id_backdrop_path = "\(movie.id)/backdrop_path" as NSString
                    
                    if let cache = MovieViewModel.cacheImages.object(forKey: id_backdrop_path) {
                        movie.backdropPath = cache
                        print("CACHE: \(id_backdrop_path)")
                    } else {
                        if let url = self?.getUrl(urlString: movieData.backdropPath) {
                            if let image = self?.getImage(url: url) {
                                movie.backdropPath = image
                                MovieViewModel.cacheImages.setObject(image, forKey: id_backdrop_path)
                                print("SERVICE: \(id_backdrop_path)")
                            }
                        }
                    }
                    
                    let id_poster_path = "\(movie.id)/poster_path" as NSString
                    
                    if let cache = MovieViewModel.cacheImages.object(forKey: id_poster_path) {
                        movie.posterPath = cache
                        print("CACHE: \(id_poster_path)")
                    } else {
                        if let url = self?.getUrl(urlString: movieData.posterPath) {
                            if let image = self?.getImage(url: url) {
                                movie.posterPath = image
                                MovieViewModel.cacheImages.setObject(image, forKey: id_poster_path)
                                print("SERVICE: \(id_poster_path)")
                            }
                        }
                    }
                    
                    self?.movies.append(movie)
                    self?.delegate?.getMovies(movies: self?.movies, error: nil)
                }
            }
        }
    }
    
    func getUrl(urlString: String) -> URL? {
        return URL(string: urlImage + urlString )
    }
    
    func getImage(url:URL) -> UIImage? {
        if let data = try? Data(contentsOf: url) {
            return UIImage(data: data)
        } else {
            return nil
        }
    }
}
