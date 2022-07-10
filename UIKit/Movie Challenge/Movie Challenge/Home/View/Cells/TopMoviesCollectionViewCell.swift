//
//  TopMoviesCollectionViewCell.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 23/06/22.
//

import UIKit

class TopMoviesCollectionViewCell: UICollectionViewCell, NibLoadable {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!

    var action: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 8
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.lightGray.cgColor
    }

    func setup(withItem item: Movie) {
        titleLabel.text = item.title
        ratingLabel.text = "⭐️ \(item.voteAverage ?? 0)/10"

        if let url = item.posterPath {
            imageView.loadFrom(url: url)
        }
    }

    @objc
    func touchUpInside() {
        action?()
    }

    func touchOnImageActionHandler(action: @escaping () -> Void) {
        self.action = action
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(touchUpInside))
        imageView.addGestureRecognizer(tapGestureRecognizer)
        imageView.isUserInteractionEnabled = true
    }

}
