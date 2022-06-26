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
    func sortByTitle() -> [SectionItem]
    func sortByRating() -> [SectionItem]
    func sortByReleaseDate() -> [SectionItem]

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

    func sortByTitle() -> [SectionItem] {

        guard let movies = movies.value else {
            return []
        }

        return movies.sorted(by: {
            $0.title ?? String() < $1.title ?? String()
        })
    }

    func sortByRating() -> [SectionItem] {

        guard let movies = movies.value else {
            return []
        }

        return movies.sorted(by: {
            $0.rating ?? 0 > $1.rating ?? 0
        })
    }

    func sortByReleaseDate() -> [SectionItem] {

        guard let movies = movies.value else {
            return []
        }

        return movies.sorted(by: {
            $0.releaseDate ?? String() > $1.releaseDate ?? String()
        })
    }
}
