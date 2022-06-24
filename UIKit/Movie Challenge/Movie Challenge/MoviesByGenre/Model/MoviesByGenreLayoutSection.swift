//
//  MoviesByGenreLayoutSection.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 24/06/22.
//

import UIKit

enum MoviesByGenreLayoutSection: Hashable {
    case main
}

extension MoviesByGenreLayoutSection {

    func layoutSection(with layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        switch self {

        case .main:

            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                 heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .absolute(300))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
            let spacing = CGFloat(10)
            group.interItemSpacing = .fixed(spacing)

            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = spacing
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10)
            return section
        }
    }
}


