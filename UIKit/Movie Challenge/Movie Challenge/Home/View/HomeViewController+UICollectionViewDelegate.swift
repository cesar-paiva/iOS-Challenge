//
//  HomeViewController+UICollectionViewDelegate.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 24/06/22.
//

import Foundation
import UIKit

extension HomeViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let section = HomeLayoutSection(rawValue: indexPath.section)

        switch section {
        case .topMovies:
            break
        case .allMovies:
            break
        case .genres:

            if let genre = sections[indexPath.section].items[indexPath.row].title {
                coordinator?.showMovies(of: genre)
            }

        case .none:
            break
        }
    }
}
