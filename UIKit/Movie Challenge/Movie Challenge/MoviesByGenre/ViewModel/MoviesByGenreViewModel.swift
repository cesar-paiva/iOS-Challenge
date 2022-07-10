//
//  MoviesByGenreViewModel.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 24/06/22.
//

import Foundation

protocol MoviesByGenreViewModelProtocol {

    var movies: Bindable<[Movie]> { get }
    var genre: String { get }

    func fetchMoviesByGenre(_ genre: String)
    func sortByTitle() -> [Movie]
    func sortByRating() -> [Movie]
    func sortByReleaseDate() -> [Movie]

}

class MoviesByGenreViewModel: MoviesByGenreViewModelProtocol {

    var movies = Bindable<[Movie]>([])
    var error: String?
    var moviesService: MoviesServiceGetable
    var genre: String

    init(moviesService: MoviesServiceGetable = MoviesService(),
         genre: String) {
        self.moviesService = moviesService
        self.genre = genre
    }

    func fetchMoviesByGenre(_ genre: String) {

        moviesService.getMoviesByGenre(genre, completion: { movies, error in

            self.movies.value = movies
            self.error = error
        })
    }

    func sortByTitle() -> [Movie] {

        guard let movies = movies.value else {
            return []
        }

        return movies.sorted(by: {
            $0.title ?? String() < $1.title ?? String()
        })
    }

    func sortByRating() -> [Movie] {

        guard let movies = movies.value else {
            return []
        }

        return movies.sorted(by: {
            $0.voteAverage ?? 0 > $1.voteAverage ?? 0
        })
    }

    func sortByReleaseDate() -> [Movie] {

        guard let movies = movies.value else {
            return []
        }

        return movies.sorted(by: {
            $0.releaseDate ?? String() > $1.releaseDate ?? String()
        })
    }
}
