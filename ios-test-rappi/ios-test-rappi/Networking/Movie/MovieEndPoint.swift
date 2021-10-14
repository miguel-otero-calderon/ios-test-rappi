//
//  MovieEndPoint.swift
//  ios-test-rappi
//
//  Created by Miguel on 14/10/21.
//

import Foundation
import Alamofire

enum MovieEndPoint: EndPoint {
        
    case getMoviesPopular
    case getMoviesTopReated
    case getMoviesUpComing
    
    var apiKey: String {
        return "?api_key=73b5d4714d05d7f1f1ac9d569f9d164f"
    }
    
    var baseURL: String {
        return "https://api.themoviedb.org"
    }
    
    var path: String {
        switch self {
        case .getMoviesPopular:
            return "/3/movie/popular"
        case .getMoviesTopReated:
            return "/3/movie/top_rated"
        case .getMoviesUpComing:
            return "/3/movie/upcoming"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getMoviesPopular, .getMoviesTopReated, .getMoviesUpComing:
            return .get
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .getMoviesPopular, .getMoviesTopReated, .getMoviesUpComing:
            return URLEncoding.default
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .getMoviesPopular, .getMoviesTopReated, .getMoviesUpComing:
            return nil
        }
    }
}
