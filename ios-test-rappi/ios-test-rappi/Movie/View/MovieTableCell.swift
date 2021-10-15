//
//  MovieTableCell.swift
//  ios-test-rappi
//
//  Created by Miguel on 15/10/21.
//

import UIKit

class MovieTableCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies:[Movie] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "MovieCollectionCell", bundle: nil),
                                     forCellWithReuseIdentifier: "MovieCollectionCell")
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

        return CGSize(width: 320, height: 140)
    }
}
