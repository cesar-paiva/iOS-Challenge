//
//  HomeViewModel.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 23/06/22.
//

import Foundation

protocol HomeViewModelProtocol {

    var topFiveMovies: Bindable<[SectionItem]> { get }
    var allMovies: Bindable<[SectionItem]> { get }

    func fetchTopFiveMovies()
    func fetchAllMovies()
}

class HomeViewModel: HomeViewModelProtocol {

    var topFiveMovies = Bindable<[SectionItem]>([])
    var allMovies = Bindable<[SectionItem]>([])
    var error: String?
    var moviesService: HomeServiceGetable

    init(moviesService: HomeServiceGetable = HomeService()) {
        self.moviesService = moviesService
    }

    func fetchTopFiveMovies() {

        moviesService.getTopFiveMovies { movies, error in

            let items = movies.map { movie in
                return SectionItem(id: UUID(),
                                   title: movie.title,
                                   subtitle: movie.releaseDate,
                                   rating: movie.voteAverage,
                                   imageName: movie.posterPath)
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
}
