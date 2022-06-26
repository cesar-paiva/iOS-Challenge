//
//  MoviesViewController+UICollectionViewDelegate.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 26/06/22.
//

import UIKit

extension MoviesViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        if let item = dataSource?.itemIdentifier(for: indexPath) {
            let movie = Movie(id: item.id,
                              title: item.title,
                              voteAverage: item.rating,
                              genres: item.genres,
                              posterPath: item.imageURL,
                              overview: item.overview,
                              cast: item.cast,
                              director: item.director,
                              releaseDate: item.releaseDate)

            coordinator?.showMovieDetails(of: movie)
        }
    }
}
