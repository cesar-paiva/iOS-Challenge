//
//  HomeViewController+UICollectionViewDelegate.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 24/06/22.
//

import UIKit

extension HomeViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if let item = dataSource?.itemIdentifier(for: indexPath) {

            switch item {

            case .topMovies(_):
                break
            case .allMovies(let movie):

                if let id = movie.id {
                    coordinator?.showMovieDetails(with: id)
                }
                
            case .genres(let genre):
                coordinator?.showMovies(of: genre)
            }
        }
    }
}
