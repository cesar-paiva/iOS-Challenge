//
//  MoviesViewModel.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 24/06/22.
//

import Foundation

protocol MoviesViewModelProtocol {

    var movies: Bindable<[SectionItem]> { get }

    func fetchAllMovies()

}

class MoviesViewModel: MoviesViewModelProtocol {

    var movies: Bindable<[SectionItem]> = Bindable<[SectionItem]>([])
    var error: String?
    var moviesService: MoviesServiceGetable

    init(moviesService: MoviesServiceGetable = MoviesService()) {
        self.moviesService = moviesService
    }

    func fetchAllMovies() {

        moviesService.getAllMovies(completion: { movies, error in

            let items = movies?.map({ movie in
                return SectionItem(id: movie.id,
                                   title: movie.title,
                                   subtitle: movie.releaseDate,
                                   rating: movie.voteAverage,
                                   genres: movie.genres,
                                   imageURL: movie.posterPath,
                                   overview: movie.overview,
                                   cast: movie.cast,
                                   director: movie.director,
                                   releaseDate: movie.releaseDate)
            })

            self.movies.value = items
            self.error = error
        })
    }
}
