//
//  HomeService.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 23/06/22.
//

import Foundation

protocol HomeServiceGetable {

    func getTopFiveMovies(completion: @escaping(_ movies: [Movie],
                                                _ error: String?) -> Void)
    func getAllMovies(completion: @escaping(_ movies: [Movie],
                                            _ error: String?) -> Void)
}

class HomeService: HomeServiceGetable {

    var movies = [Movie]()

    func getTopFiveMovies(completion: @escaping(_ movies: [Movie],
                                         _ error: String?) -> Void) {

        let query = GetTopFiveMoviesQuery()

        Network.shared.apollo.fetch(query: query) { result in
          switch result {
            case .success(let graphQLResult):

              if let movies = graphQLResult.data?.movies {
                  self.movies = movies.map({ Movie(title: $0?.title, releaseDate: $0?.releaseDate, voteAverage: $0?.voteAverage, posterPath: $0?.posterPath) })
              }

              completion(self.movies, nil)

            case .failure(let error):
              completion(self.movies, error.localizedDescription)
          }
        }
    }

    func getAllMovies(completion: @escaping(_ movies: [Movie],
                                         _ error: String?) -> Void) {

        let query = GetAllMoviesQuery()

        Network.shared.apollo.fetch(query: query) { result in
          switch result {
            case .success(let graphQLResult):

              if let movies = graphQLResult.data?.movies {
                  self.movies = movies.map({ Movie(title: $0?.title, releaseDate: $0?.releaseDate, voteAverage: $0?.voteAverage, posterPath: $0?.posterPath) })
              }

              completion(self.movies, nil)

            case .failure(let error):
              completion(self.movies, error.localizedDescription)
          }
        }
    }
}
