//
//  MovieView.swift
//  ios-test-rappi
//
//  Created by Miguel on 14/10/21.
//

import UIKit

class MovieView: UIViewController {

    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var viemModel: MovieViewModelProtocol = MovieViewModel(service: MovieService())
    var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viemModel.delegate = self
        self.viemModel.getMovies(movieType: .popular)
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
    
}
extension MovieView: MovieViewModelDelegate {
    func getMovies(movies: [Movie]?, error: Error?) {
        self.movies = movies!
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
        
        if indexPath.section == 0 {
            cell?.movies = self.movies.filter({ movie in movie.movieType == .popular })
        } else if indexPath.section == 1 {
            cell?.movies = self.movies.filter({ movie in movie.movieType == .topRated })
        } else if indexPath.section == 2 {
            cell?.movies = self.movies.filter({ movie in movie.movieType == .upComing })
        }
        
        if let movies = cell?.movies {
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
