//
//  MoviesViewModel.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 24/06/22.
//

import Foundation

protocol MoviesViewModelProtocol {

    var movies: Bindable<[Movie]> { get }

    func fetchAllMovies()
    func sortByTitle() -> [Movie]
    func sortByRating() -> [Movie]
    func sortByReleaseDate() -> [Movie]
    func filteredMovies(with text: String) -> [Movie]

}

class MoviesViewModel: MoviesViewModelProtocol {

    var movies: Bindable<[Movie]> = Bindable<[Movie]>([])
    var error: String?
    var moviesService: MoviesServiceGetable

    init(moviesService: MoviesServiceGetable = MoviesService()) {
        self.moviesService = moviesService
    }

    func fetchAllMovies() {

        moviesService.getMovies(limit: nil, completion: { movies, error in

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

    func filteredMovies(with text: String) -> [Movie] {

        guard let movies = movies.value else {
            return []
        }

        return movies.filter({
            $0.contains(text)
        })
    }
}
