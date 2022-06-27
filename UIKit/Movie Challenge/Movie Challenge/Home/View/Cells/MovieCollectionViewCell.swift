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
    
    func setup(withItem item: SectionItem) {

        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle?.prefix(4).description

        if let url = item.imageURL {
            imageView.loadFrom(url: url)
        }
    }
    
}
