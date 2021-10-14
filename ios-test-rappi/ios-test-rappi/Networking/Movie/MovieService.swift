//
//  MovieService.swift
//  ios-test-rappi
//
//  Created by Miguel on 14/10/21.
//

import Foundation
import Alamofire

protocol MovieServiceProtocol{
    func getMovies(request: MovieRequest, completion: @escaping (MovieResponse?, Error?) -> Void)
}

class MovieService: MovieServiceProtocol {
    
    func getMovies(request: MovieRequest, completion: @escaping (MovieResponse?, Error?) -> Void) {
        var endPoint: MovieEndPoint
        switch request.movieType {
        case .popular:
            endPoint = .getMoviesPopular
        case .topRated:
            endPoint = .getMoviesTopReated
        case .upComing:
            endPoint = .getMoviesUpComing
        }
        
        AF.request(endPoint.toURL(), method: endPoint.method)
            .response {[weak self] response in
                switch response.result {
                case .success(let data):
                    guard let data = data else {
                        return
                    }
                    do {
                        let response = try JSONDecoder().decode(MovieResponse.self, from: data)
                        completion(response, nil)
                    } catch {
                        completion(nil,error)
                    }
                case .failure(let error):
                    completion(nil,error)
                }
            }
    }
}
