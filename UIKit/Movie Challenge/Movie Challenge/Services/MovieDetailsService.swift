//
//  MovieDetailsService.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 23/06/22.
//

import Foundation

protocol MovieDetailsServiceGetable {

    func getMovie(withId: Int,
                      completion: @escaping(_ movie: MovieDetails?,
                                            _ error: String?) -> Void)
}

class MovieDetailsService: MovieDetailsServiceGetable {

    func getMovie(withId id: Int,
                      completion: @escaping(_ movies: MovieDetails?,
                                            _ error: String?) -> Void) {

        let query = GetMovieQuery(id: id)
        var movie: MovieDetails?

        Network.shared.apollo.fetch(query: query) { result in
            switch result {
            case .success(let graphQLResult):

                if let movieData = graphQLResult.data?.movie {

                    movie = MovieDetails(id: movieData.id,
                                        title: movieData.title,
                                        voteAverage: movieData.voteAverage,
                                        genres: movieData.genres,
                                        imageURL: movieData.posterPath,
                                        overview: movieData.overview,
                                        releaseDate: movieData.releaseDate,
                                        cast: movieData.cast.map({ Cast(profilePath: $0.profilePath, name: $0.name)}),
                                        director: Director(name: movieData.director.name))

                }

                completion(movie, nil)

            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
}
