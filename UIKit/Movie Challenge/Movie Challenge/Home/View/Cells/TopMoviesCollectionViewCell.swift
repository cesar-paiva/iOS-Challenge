//
//  TopMoviesCollectionViewCell.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 23/06/22.
//

import UIKit

class TopMoviesCollectionViewCell: UICollectionViewCell {

    static var nib: UINib {
        UINib(nibName: String(describing: Self.self), bundle: nil)
    }

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 8
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.lightGray.cgColor
    }

    func setup(withItem item: SectionItem) {
        titleLabel.text = item.title
        ratingLabel.text = "⭐️ \(item.rating ?? 0)/10"

        if let url = item.imageName {
            imageView.loadFrom(url: url)
        }
    }

}
