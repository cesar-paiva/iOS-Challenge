//
//  HomeViewController+UICollectionViewDelegate.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 24/06/22.
//

import UIKit

extension HomeViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let section = HomeLayoutSection(rawValue: indexPath.section)

        switch section {
        case .topMovies:
            break
        case .movies:

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

        case .genres:

            if let genre = sections[indexPath.section].items[indexPath.row].title {
                coordinator?.showMovies(of: genre)
            }

        case .none:
            break
        }
    }
}
