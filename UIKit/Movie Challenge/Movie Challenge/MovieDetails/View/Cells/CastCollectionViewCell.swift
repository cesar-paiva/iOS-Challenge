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

    func setup(withCast cast: Cast) {

        if let url = cast.profilePath {
            imageView.loadFrom(url: url)
        }
        textLabel.text = cast.name
    }
}

class RoundedImageView: UIImageView {

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width / 2
    }

}
