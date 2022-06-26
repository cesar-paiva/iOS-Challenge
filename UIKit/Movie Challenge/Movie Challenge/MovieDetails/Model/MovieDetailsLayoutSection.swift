//
//  MovieDetailsLayoutSection.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 24/06/22.
//

import UIKit

enum MovieDetailsLayoutSection: Int, Hashable {
    case details
    case cast
}

extension MovieDetailsLayoutSection {

    func layoutSection(with layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        switch self {

        case .details:

            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                                 heightDimension: .estimated(1)))

            let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                                              heightDimension: .estimated(1)),
                                                           subitems: [item])

            let section = NSCollectionLayoutSection(group: group)
            section.supplementariesFollowContentInsets = false
            return section
        case .cast:

            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                                 heightDimension: .estimated(1)))

            let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                                                              heightDimension: .estimated(1)),
                                                           subitem: item,
                                                           count: 4)
            group.interItemSpacing = .fixed(16)

            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 16

            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16)
            section.supplementariesFollowContentInsets = false
            section.boundarySupplementaryItems = [supplementaryHeaderItem()]
            return section
        }
    }

    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                       heightDimension: .estimated(100)),
                                                    elementKind: UICollectionView.elementKindSectionHeader,
                                                    alignment: .top)

    }
}

