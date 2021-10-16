//
//  MovieCollectionCell.swift
//  ios-test-rappi
//
//  Created by Miguel on 15/10/21.
//

import UIKit

class MovieCollectionCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    var movie:Movie?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(movie:Movie) {
        imageView.image = movie.backdropImage
        titleLabel.text = movie.title
        self.movie = movie
    }
}
