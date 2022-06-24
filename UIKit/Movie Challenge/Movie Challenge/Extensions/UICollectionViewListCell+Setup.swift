//
//  UICollectionViewListCell+Setup.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 23/06/22.
//

import UIKit

extension UICollectionViewListCell {

    func setup(withItem item: SectionItem) {

        var content = defaultContentConfiguration()
        content.text = item.title
        contentConfiguration = content
    }
}
