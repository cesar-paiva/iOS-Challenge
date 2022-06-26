//
//  MovieDetailsCollectionViewCell.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 23/06/22.
//

import UIKit

class MovieDetailsCollectionViewCell: UICollectionViewCell {
    
    static var nib: UINib {
        UINib(nibName: String(describing: Self.self), bundle: nil)
    }

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!


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
        overviewLabel.text = item.overview
    }
}
