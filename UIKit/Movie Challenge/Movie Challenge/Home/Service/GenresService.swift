//
//  GenresService.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 24/06/22.
//

import Foundation

protocol GenresServiceGetable {

    func getGenres(completion: @escaping(_ genres: [String],
                                         _ error: String?) -> Void)
}

class GenresService: GenresServiceGetable {

    var genres = [String]()

    func getGenres(completion: @escaping(_ genres: [String],
                                         _ error: String?) -> Void) {

        let query = GetGenresQuery()

        Network.shared.apollo.fetch(query: query) { result in
          switch result {
            case .success(let graphQLResult):
              completion(graphQLResult.data?.genres ?? [], nil)
            case .failure(let error):
              completion(self.genres, error.localizedDescription)
          }
        }
    }
}
