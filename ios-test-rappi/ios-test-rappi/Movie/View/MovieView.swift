//
//  MovieView.swift
//  ios-test-rappi
//
//  Created by Miguel on 14/10/21.
//

import UIKit

class MovieView: UIViewController {

    var viemModel: MovieViewModelProtocol = MovieViewModel(service: MovieService())
    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viemModel.delegate = self
        self.viemModel.getMovies(movieType: .popular)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
}
extension MovieView: MovieViewModelDelegate {
    func getMovies(movies: [Movie]?, error: Error?) {
        print(movies)
    }
}
