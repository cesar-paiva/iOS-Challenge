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
    let posterPath: String?
    let releaseDate: String?
    let director: Director?

    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
        hasher.combine(id)
        hasher.combine(title)
    }
}

extension Movie {

    func contains(_ text: String?) -> Bool {

        guard let text = text else { return true }

        if text.isEmpty { return true }

        let lowercasedFilter = text.lowercased()
        return title?.lowercased().contains(lowercasedFilter) ?? false || director?.name?.lowercased().contains(lowercasedFilter) ?? false
    }
}
