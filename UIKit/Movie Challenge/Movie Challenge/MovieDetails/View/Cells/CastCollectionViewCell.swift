//
//  CastCollectionViewCell.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 25/06/22.
//

import UIKit

class CastCollectionViewCell: UICollectionViewCell, NibLoadable {

    @IBOutlet weak var imageView: RoundedImageView!
    @IBOutlet weak var textLabel: UILabel!

    func setup(withItem item: MoviesDetailsSectionItem) {

        if let url = item.imageURL {
            imageView.loadFrom(url: url)
        }
        textLabel.text = item.title
    }
}

class RoundedImageView: UIImageView {

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width / 2
    }

}
