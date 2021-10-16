//
//  MovieTableCell.swift
//  ios-test-rappi
//
//  Created by Miguel on 15/10/21.
//

import UIKit

protocol MovieTableCellDelegate {
    func isSelected(movie:Movie)
}

class MovieTableCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies:[Movie] = []
    var delegate:MovieTableCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "MovieCollectionCell", bundle: nil),
                                     forCellWithReuseIdentifier: "MovieCollectionCell")
        self.collectionView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(movies: [Movie]) {
        self.movies = movies
        self.collectionView.reloadData()
    }
}

extension MovieTableCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionCell", for: indexPath) as? MovieCollectionCell
        
        let movie = self.movies[indexPath.row]
        
        cell?.configure(movie: movie)
        
        return cell!
    }
}

extension MovieTableCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 200, height: 140)
    }
}

extension MovieTableCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let movie = self.movies[indexPath.row]
        
        self.delegate?.isSelected(movie: movie)
        print(movie.title)
    }
}
