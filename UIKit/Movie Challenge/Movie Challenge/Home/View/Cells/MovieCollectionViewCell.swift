//
//  MovieCollectionViewCell.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 23/06/22.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell, NibLoadable {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 4
    }
    
    func setup(withItem item: Movie) {

        titleLabel.text = item.title
        subtitleLabel.text = "⭐️ \(item.voteAverage ?? 0)/10"

        if let url = item.posterPath {
            imageView.loadFrom(url: url)
        }
    }
    
}
