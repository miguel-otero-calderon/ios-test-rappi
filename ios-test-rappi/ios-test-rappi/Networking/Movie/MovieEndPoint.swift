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
    
    var apiKey: String {
        return "https://api.themoviedb.org"
    }
    
    var baseURL: String {
        return "https://61572bb98f7ea60017985113.mockapi.io"
    }
    
    var path: String {
        switch self {
        case .getMoviesPopular: return "/3/movie/popular"
        }
    }
    
    var metohd: HTTPMethod {
        switch self {
        case .getMoviesPopular:
            return .get
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .getMoviesPopular:
            return URLEncoding.default
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .getMoviesPopular:
            return nil
        }
    }
}
