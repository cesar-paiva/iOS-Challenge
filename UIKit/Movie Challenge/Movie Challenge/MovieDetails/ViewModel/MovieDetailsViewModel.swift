//
//  MovieDetailsViewModel.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 24/06/22.
//

import Foundation

protocol MovieDetailsViewModelProtocol {

    var movie: Movie { get }
    var movieDetail: [MoviesDetailsSectionItem] { get }
    var cast: [MoviesDetailsSectionItem] { get }
}

class MovieDetailsViewModel: MovieDetailsViewModelProtocol {

    var movie: Movie

    var title: String? {
        return movie.title
    }

    var rating: String? {
        return "⭐️ \(movie.voteAverage ?? 0)/10"
    }

    var genres: String? {
        return movie.genres?.joined(separator: " • ")
    }

    var imageURL: String? {
        return movie.posterPath
    }

    var overview: String? {
        return movie.overview
    }

    var movieDetail: [MoviesDetailsSectionItem] {
        return [MoviesDetailsSectionItem(id: movie.id,
                                        title: movie.title,
                                        rating: rating,
                                        genres: genres,
                                        imageURL: movie.posterPath,
                                        overview: movie.overview)]
    }

    var cast: [MoviesDetailsSectionItem] {

        return movie.cast?.map({ cast in
            return (MoviesDetailsSectionItem(title: cast.name, imageURL: cast.profilePath))
        }) ?? []
    }

    init(movie: Movie) {
        self.movie = movie
    }
}
