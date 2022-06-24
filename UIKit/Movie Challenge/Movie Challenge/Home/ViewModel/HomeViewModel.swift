//
//  HomeViewModel.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 23/06/22.
//

import Foundation

protocol HomeViewModelProtocol {

    var allMovies: Bindable<[SectionItem]> { get }
    var topFiveMovies: Bindable<[SectionItem]> { get }
    var genres: Bindable<[SectionItem]> { get }

    func fetchTopFiveMovies()
    func fetchAllMovies()
    func fetchGenres()

}

class HomeViewModel: HomeViewModelProtocol {

    var allMovies = Bindable<[SectionItem]>([])
    var topFiveMovies = Bindable<[SectionItem]>([])
    var genres = Bindable<[SectionItem]>([])
    var error: String?
    var moviesService: HomeServiceGetable
    var genresService: GenresServiceGetable

    init(moviesService: HomeServiceGetable = HomeService(),
         genresService: GenresServiceGetable = GenresService()) {
        self.moviesService = moviesService
        self.genresService = genresService
    }

    func fetchTopFiveMovies() {

        moviesService.getTopFiveMovies { movies, error in

            let items = movies.map { movie in
                return SectionItem(id: UUID(), title: movie.title, subtitle: movie.releaseDate, rating: movie.voteAverage, imageName: movie.posterPath)
            }

            self.topFiveMovies.value = items
            self.error = error
        }
    }

    func fetchAllMovies() {

        moviesService.getAllMovies { movies, error in

            let items = movies.map { movie in
                return SectionItem(id: UUID(), title: movie.title, subtitle: movie.releaseDate, rating: movie.voteAverage, imageName: movie.posterPath)
            }

            self.allMovies.value = items
            self.error = error
        }
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
