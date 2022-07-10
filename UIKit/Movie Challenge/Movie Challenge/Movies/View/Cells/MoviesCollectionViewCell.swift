//
//  MoviesCollectionViewCell.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 24/06/22.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell, NibLoadable {

    @IBOutlet weak var imageView: CacheableImageView!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        imageView.cancelLoadingImage()
    }

    func setup(withMovie movie: Movie) {
        titleLabel.text = movie.title

        if let url = movie.posterPath {
            imageView.downloadAndCacheImage(fromURL: url)
        }
    }
}
