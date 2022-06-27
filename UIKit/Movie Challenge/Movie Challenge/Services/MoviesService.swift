//
//  MoviesService.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 23/06/22.
//

import Foundation

protocol MoviesServiceGetable {

    func getTopMovies(limit: Int,
                      completion: @escaping(_ movies: [Movie]?,
                                            _ error: String?) -> Void)
    func getMovies(limit: Int?,
                   completion: @escaping(_ movies: [Movie]?,
                                         _ error: String?) -> Void)
    func getMoviesByGenre(_ genre: String,
                          completion: @escaping(_ movies: [Movie]?,
                                                _ error: String?) -> Void)

}

class MoviesService: MoviesServiceGetable {

    func getTopMovies(limit: Int,
                      completion: @escaping(_ movies: [Movie]?,
                                            _ error: String?) -> Void) {

        let query = GetTopMoviesQuery(limit: limit)
        var movies = [Movie]()

        Network.shared.apollo.fetch(query: query) { result in
            switch result {
            case .success(let graphQLResult):

                if let moviesData = graphQLResult.data?.movies {

                    movies = moviesData.map({ movie in
                        Movie(id: movie?.id,
                              title: movie?.title,
                              voteAverage: movie?.voteAverage,
                              genres: movie?.genres,
                              posterPath: movie?.posterPath,
                              overview: movie?.overview,
                              cast: movie?.cast.map({ Cast(profilePath: $0.profilePath, name: $0.name) }),
                              director: Director(name: movie?.director.name ?? String()),
                              releaseDate: movie?.releaseDate)
                    })
                }

                completion(movies, nil)

            case .failure(let error):
                completion(movies, error.localizedDescription)
            }
        }
    }

    func getMovies(limit: Int?,
                   completion: @escaping(_ movies: [Movie]?,
                                         _ error: String?) -> Void) {

        let query = GetMoviesQuery(limit: limit)
        var movies = [Movie]()

        Network.shared.apollo.fetch(query: query) { result in
            switch result {
            case .success(let graphQLResult):

                if let moviesData = graphQLResult.data?.movies {

                    movies = moviesData.map({ movie in
                        Movie(id: movie?.id,
                              title: movie?.title,
                              voteAverage: movie?.voteAverage,
                              genres: movie?.genres,
                              posterPath: movie?.posterPath,
                              overview: movie?.overview,
                              cast: movie?.cast.map({ Cast(profilePath: $0.profilePath, name: $0.name) }),
                              director: Director(name: movie?.director.name),
                              releaseDate: movie?.releaseDate)
                    })
                }

                completion(movies, nil)

            case .failure(let error):
                completion(movies, error.localizedDescription)
            }
        }
    }

    func getMoviesByGenre(_ genre: String, completion: @escaping ([Movie]?, String?) -> Void) {

        let query = GetMoviesByGenreQuery(genre: genre)
        var movies = [Movie]()

        Network.shared.apollo.fetch(query: query) { result in
            switch result {
            case .success(let graphQLResult):

                if let moviesData = graphQLResult.data?.movies {
                    movies = moviesData.map({ movie in
                        Movie(id: movie?.id,
                              title: movie?.title,
                              voteAverage: movie?.voteAverage,
                              genres: movie?.genres,
                              posterPath: movie?.posterPath,
                              overview: movie?.overview,
                              cast: movie?.cast.map({ Cast(profilePath: $0.profilePath, name: $0.name) }),
                              director: Director(name: movie?.director.name),
                              releaseDate: movie?.releaseDate)
                    })
                }

                completion(movies, nil)

            case .failure(let error):
                completion(movies, error.localizedDescription)
            }
        }
    }
}
