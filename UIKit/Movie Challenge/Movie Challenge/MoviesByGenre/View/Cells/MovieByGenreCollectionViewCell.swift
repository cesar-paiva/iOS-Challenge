//
//  MovieByGenreCollectionViewCell.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 24/06/22.
//

import UIKit

class MovieByGenreCollectionViewCell: UICollectionViewCell {

    static var nib: UINib {
        UINib(nibName: String(describing: Self.self), bundle: nil)
    }

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setup(withItem item: SectionItem) {
        titleLabel.text = item.title

        if let url = item.imageURL {
            imageView.loadFrom(url: url)
        }
    }

}
