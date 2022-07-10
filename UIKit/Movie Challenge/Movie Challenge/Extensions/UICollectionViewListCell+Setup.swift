//
//  UICollectionViewListCell+Setup.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 23/06/22.
//

import UIKit

extension UICollectionViewListCell {

    func setup(withTitle text: String) {

        var content = defaultContentConfiguration()
        content.text = text
        contentConfiguration = content
    }
}
