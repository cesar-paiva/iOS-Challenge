//
//  MovieDetailsCollectionViewCell.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 23/06/22.
//

import UIKit

class MovieDetailsCollectionViewCell: UICollectionViewCell, NibLoadable {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(withMovieDetails movieDetails: MovieDetails) {

        if let url = movieDetails.imageURL {
            imageView.loadFrom(url: url)
        }

        titleLabel.text = movieDetails.title
        ratingLabel.text = "⭐️ \(movieDetails.voteAverage)/10"
        genresLabel.text = movieDetails.genres.joined(separator: " • ")
        directorLabel.text = "Directed by \(movieDetails.director.name ?? String())"
        overviewLabel.text = movieDetails.overview
    }
}
