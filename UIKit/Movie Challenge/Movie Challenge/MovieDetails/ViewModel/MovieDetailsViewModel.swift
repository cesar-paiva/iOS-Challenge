//
//  MovieDetailsViewModel.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 24/06/22.
//

import Foundation

protocol MovieDetailsViewModelProtocol {

    var movie: Bindable<MovieDetails> { get }

    func fetchMovie(withId: Int)
}

class MovieDetailsViewModel: MovieDetailsViewModelProtocol {

    var movieDetailsService: MovieDetailsServiceGetable
    var movie = Bindable<MovieDetails>(nil)
    var error: String?

    init(movieDetailsService: MovieDetailsServiceGetable = MovieDetailsService()) {
        self.movieDetailsService = movieDetailsService
    }

    func fetchMovie(withId id: Int) {

        movieDetailsService.getMovie(withId: id) { movie, error in

            self.movie.value = movie
            self.error = error
        }
    }
}
