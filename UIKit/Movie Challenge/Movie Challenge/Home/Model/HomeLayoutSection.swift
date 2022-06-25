//
//  HomeLayoutSection.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 23/06/22.
//

import UIKit

enum HomeLayoutSection: Int, Hashable {
    case topMovies
    case movies
    case genres
}

extension HomeLayoutSection {

    func layoutSection(with layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        switch self {

        case .topMovies:

            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1)))

            let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.75), heightDimension: .estimated(1)), subitems: [item])

            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 16
            section.orthogonalScrollingBehavior = .continuous
            section.contentInsets = .init(top: 0, leading: 16, bottom: 16, trailing: 16)
            section.supplementariesFollowContentInsets = false
            section.boundarySupplementaryItems = [supplementaryHeaderItem(), supplementaryFooterSeparatorItem()]
            return section
        case .movies:

            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))

            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitems: [item])

            let containerGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.8),heightDimension: .estimated(1)), subitems: Array(repeating: group, count: 3))
            containerGroup.interItemSpacing = .fixed(16)

            let section = NSCollectionLayoutSection(group: containerGroup)
            section.interGroupSpacing = 16
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16)
            section.supplementariesFollowContentInsets = false
            section.orthogonalScrollingBehavior = .groupPaging
            section.boundarySupplementaryItems = [supplementaryHeaderItem(), supplementaryFooterSeparatorItem()]
            return section
        case .genres:

            var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
            listConfiguration.showsSeparators = true
            listConfiguration.headerMode = .supplementary
            let list = NSCollectionLayoutSection.list(using: listConfiguration, layoutEnvironment: layoutEnvironment)
            return list
        }
    }

    private func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                       heightDimension: .estimated(100)),
                                                    elementKind: UICollectionView.elementKindSectionHeader,
                                                    alignment: .top)

    }

    private func supplementaryFooterSeparatorItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                       heightDimension: .absolute(1)),
                                                    elementKind: UICollectionView.elementKindSectionFooter,
                                                    alignment: .bottom)
    }

}

