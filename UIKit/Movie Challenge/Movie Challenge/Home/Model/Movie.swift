//
//  Movie.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 23/06/22.
//

import Foundation

struct Movie: Codable, Hashable {

    var uuid: UUID = UUID()
    let id: Int?
    let title: String?
    let voteAverage: Double?
    let genres: [String]?
    let posterPath: String?
    let overview: String?
    let cast: [Cast]?
    let director: Director?
    let releaseDate: String?

    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
        hasher.combine(id)
        hasher.combine(title)
    }
}

struct Cast: Codable, Hashable {

    let profilePath: String?
    let name: String?
}

struct Director: Codable, Hashable {
    let name: String?
}
