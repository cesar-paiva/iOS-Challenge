//
//  HomeViewModel.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 23/06/22.
//

import Foundation

protocol HomeViewModelProtocol {

    var topFiveMovies: Bindable<[SectionItem]> { get }

    func fetchTopFiveMovies()
}

class HomeViewModel: HomeViewModelProtocol {

    var topFiveMovies = Bindable<[SectionItem]>([])
    var error: String?
    var moviesService: MoviesServiceGetable

    init(moviesService: MoviesServiceGetable = HomeService()) {
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
}
