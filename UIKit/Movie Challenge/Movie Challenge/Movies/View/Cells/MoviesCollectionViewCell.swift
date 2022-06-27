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

    func setup(withItem item: SectionItem) {
        titleLabel.text = item.title

        if let url = item.imageURL {
            imageView.downloadAndCacheImage(fromURL: url)
        }
    }
}
