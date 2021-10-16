//
//  MovieView.swift
//  ios-test-rappi
//
//  Created by Miguel on 14/10/21.
//

import Foundation
import UIKit

class MovieView: UIViewController {

    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viemModel: MovieViewModelProtocol = MovieViewModel(service: MovieService())
    var moviesPopular : [Movie] = []
    var moviesTopRated: [Movie] = []
    var moviesUpComing: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viemModel.delegate = self
        self.viemModel.getMovies(movieType: .popular)
        self.viemModel.getMovies(movieType: .topRated)
        self.viemModel.getMovies(movieType: .upComing)
        self.tableView.isHidden = true
        self.searchView.isHidden = true
        self.activityIndicator.startAnimating()
        self.activityIndicator.hidesWhenStopped = true
        
        self.tableView.register(UINib(nibName: "MovieTableCell", bundle: nil), forCellReuseIdentifier: "MovieTableCell")
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func getImages(movies:[Movie]) -> [Movie] {
        var moviesWithImage: [Movie] = movies
        for (index,movie) in movies.enumerated() {
            if movie.backdropImage == nil {
                moviesWithImage[index].backdropImage = self.viemModel.getCache(id: moviesWithImage[index].idBackdropPath)
            }
            if movie.posterImage == nil {
                moviesWithImage[index].posterImage = self.viemModel.getCache(id: moviesWithImage[index].idPosterPath)
            }
        }
        return moviesWithImage
    }
}
extension MovieView: MovieViewModelDelegate {
    func getMovies(movies: [Movie]?, error: Error?) {
        
        guard let movies = movies else {
            return
        }
        
        guard movies.count > 0 else {
            return
        }
        
        if movies.contains(where: { movie in movie.backdropImage == nil || movie.posterImage == nil }){
            sleep(2)
        }
        
        let moviesWithImage = getImages(movies: movies)
        
        if movies.contains(where: { Movie in Movie.movieType == .popular }) {
            self.moviesPopular = moviesWithImage
        }
        
        if movies.contains(where: { Movie in Movie.movieType == .topRated }) {
            self.moviesTopRated = moviesWithImage
        }
        
        if movies.contains(where: { Movie in Movie.movieType == .upComing }) {
            self.moviesUpComing = moviesWithImage
        }
                
        DispatchQueue.main.async {
            self.tableView.isHidden = false
            self.searchView.isHidden = false
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }
    }
}

extension MovieView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Polular"
        case 1:
            return "Top Rated"
        case 2:
            return "Upcomming"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableCell", for: indexPath) as? MovieTableCell
        
        self.moviesPopular = getImages(movies: self.moviesPopular)
        self.moviesTopRated = getImages(movies: self.moviesTopRated)
        self.moviesUpComing = getImages(movies: self.moviesUpComing)
        
        if indexPath.section == 0 {
            cell?.movies = self.moviesPopular
        }
        
        if indexPath.section == 1 {
            cell?.movies = self.moviesTopRated
        }
        
        if indexPath.section == 2 {
            cell?.movies = self.moviesUpComing
        }
        
        if let movies = cell?.movies, movies.count > 0 {
            cell!.configure(movies: movies)
        }
        
        return cell!
    }
}

extension MovieView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
