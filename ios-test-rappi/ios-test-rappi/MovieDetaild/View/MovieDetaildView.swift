//
//  MovieDetaildView.swift
//  ios-test-rappi
//
//  Created by Miguel on 15/10/21.
//

import UIKit

class MovieDetaildView: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var sinopsysLabel: UILabel!
    @IBOutlet weak var votosLabel: UILabel!
    
    var movie:Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let movie = movie else {
            return
        }

        imageView.image = movie.backdropImage
        titleLabel.text = movie.title
        genderLabel.text = "\(movie.popularity)"
        releaseLabel.text = movie.releaseDate
        sinopsysLabel.text = movie.overview
        votosLabel.text = "\(movie.voteCount)"
    }
    

}
