//
//  MovieDetails.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 08/07/22.
//

import Foundation

struct MovieDetails: Codable, Hashable {

    let id: Int
    let title: String
    let voteAverage: Double
    let genres: [String]
    let imageURL: String?
    let overview: String
    let releaseDate: String
    let cast: [Cast]
    let director: Director
}

struct Cast: Codable, Hashable {

    let profilePath: String?
    let name: String?
}

struct Director: Codable, Hashable {
    let name: String?
}
