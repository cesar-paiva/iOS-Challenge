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
    
    func setup(withItem item: MoviesDetailsSectionItem) {

        if let url = item.imageURL {
            imageView.loadFrom(url: url)
        }

        titleLabel.text = item.title
        ratingLabel.text = item.rating
        genresLabel.text = item.genres
        directorLabel.text = "Directed by \(item.director ?? String())"
        overviewLabel.text = item.overview
    }
}
