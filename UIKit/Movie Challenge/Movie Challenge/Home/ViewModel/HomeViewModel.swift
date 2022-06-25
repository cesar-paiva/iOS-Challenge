//
//  HomeViewModel.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 23/06/22.
//

import Foundation

protocol HomeViewModelProtocol {

    var allMovies: Bindable<[SectionItem]> { get }
    var topMovies: Bindable<[SectionItem]> { get }
    var genres: Bindable<[SectionItem]> { get }
    var topMoviesLimit: Int { get }
    var moviesLimit: Int { get }

    func fetchTopMovies()
    func fetchMovies(limit: Int)
    func fetchGenres()

}

class HomeViewModel: HomeViewModelProtocol {

    var allMovies = Bindable<[SectionItem]>([])
    var topMovies = Bindable<[SectionItem]>([])
    var genres = Bindable<[SectionItem]>([])
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

            let items = movies.map { movie in
                return SectionItem(id: UUID(), title: movie.title, subtitle: movie.releaseDate, rating: movie.voteAverage, imageName: movie.posterPath)
            }

            self.topMovies.value = items
            self.error = error
        }
    }

    func fetchMovies(limit: Int) {

        moviesService.getMovies(limit: limit, completion: { movies, error in

            let items = movies.map { movie in
                return SectionItem(id: UUID(), title: movie.title, subtitle: movie.releaseDate, rating: movie.voteAverage, imageName: movie.posterPath)
            }

            self.allMovies.value = items
            self.error = error
        })
    }

    func fetchGenres() {

        genresService.getGenres { genres, error in

            let items = genres.map { genre in
                return SectionItem(id: UUID(), title: genre)
            }

            self.genres.value = items
            self.error = error
        }

    }
}
