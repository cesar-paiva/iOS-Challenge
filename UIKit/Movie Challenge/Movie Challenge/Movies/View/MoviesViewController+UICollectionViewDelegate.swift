//
//  MoviesViewController+UICollectionViewDelegate.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 26/06/22.
//

import UIKit

extension MoviesViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if let item = dataSource.itemIdentifier(for: indexPath) {

            switch item {

            case .movie(let movie):

                if let id = movie.id {
                    coordinator?.showMovieDetails(with: id)
                }
            }
        }
    }
}
