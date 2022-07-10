//
//  HomeViewModel.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 23/06/22.
//

import Foundation

protocol HomeViewModelProtocol {

    var allMovies: Bindable<[Movie]> { get }
    var topMovies: Bindable<[Movie]> { get }
    var genres: Bindable<[String]> { get }
    var topMoviesLimit: Int { get }
    var moviesLimit: Int { get }

    func fetchTopMovies()
    func fetchMovies(limit: Int)
    func fetchGenres()

}

class HomeViewModel: HomeViewModelProtocol {

    var allMovies = Bindable<[Movie]>([])
    var topMovies = Bindable<[Movie]>([])
    var genres = Bindable<[String]>([])
    var error: String?
    var moviesService: MoviesServiceGetable
    var genresService: GenresServiceGetable
    let topMoviesLimit = 5
    let moviesLimit = 15

    init(moviesService: MoviesServiceGetable = MoviesService(),
         genresService: GenresServiceGetable = GenresService()) {
        self.moviesService = moviesService
        self.genresService = genresService
    }

    func fetchTopMovies() {

        moviesService.getTopMovies(limit: topMoviesLimit) { movies, error in

            self.topMovies.value = movies
            self.error = error
        }
    }

    func fetchMovies(limit: Int) {

        moviesService.getMovies(limit: limit, completion: { movies, error in

            self.allMovies.value = movies
            self.error = error
        })
    }

    func fetchGenres() {

        genresService.getGenres { genres, error in

            self.genres.value = genres
            self.error = error
        }
    }
}
