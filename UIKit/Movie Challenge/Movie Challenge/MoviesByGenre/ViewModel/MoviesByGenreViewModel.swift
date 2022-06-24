//
//  MoviesByGenreViewModel.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 24/06/22.
//

import Foundation

protocol MoviesByGenreViewModelProtocol {

    var movies: Bindable<[SectionItem]> { get }
    var genre: String { get }

    func fetchMoviesByGenre(_ genre: String)

}

class MoviesByGenreViewModel: MoviesByGenreViewModelProtocol {

    var movies: Bindable<[SectionItem]> = Bindable<[SectionItem]>([])
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

            let items = movies.map { movie in
                return SectionItem(id: UUID(), title: movie.title, imageName: movie.posterPath)
            }

            self.movies.value = items
            self.error = error
        })
    }
}
