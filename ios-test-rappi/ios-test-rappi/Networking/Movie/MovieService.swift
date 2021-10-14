//
//  MovieService.swift
//  ios-test-rappi
//
//  Created by Miguel on 14/10/21.
//

import Foundation
import Alamofire

protocol MovieServiceProtocol{
    func getMoviesPopular(request: MovieRequest?, completion: @escaping (MoviePopularResponse?, Error?) -> Void)
}
class MovieService: MovieServiceProtocol {
    
    func getMoviesPopular(request: MovieRequest?, completion: @escaping (MoviePopularResponse?, Error?) -> Void) {
        AF.request(
            MovieEndPoint.getMoviesPopular.toURL(),
            method: MovieEndPoint.getMoviesPopular.metohd)
            .response {[weak self] response in
                switch response.result {
                case .success(let data):
                    guard let data = data else {
                        return
                    }
                    do {
                        let response = try JSONDecoder().decode(MoviePopularResponse.self, from: data)
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
