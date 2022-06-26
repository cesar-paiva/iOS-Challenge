//
//  SectionItem.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 23/06/22.
//

import Foundation

struct SectionItem: Codable, Hashable {

    let uuid: UUID
    let id: Int?
    let title: String?
    let subtitle: String?
    let rating: Double?
    let genres: [String]?
    let imageURL: String?
    let overview: String?
    let cast: [Cast]?
    let director: Director?
    let releaseDate: String?

    init(id: Int? = nil,
         title: String? = nil,
         subtitle: String? = nil,
         rating: Double? = nil,
         genres: [String]? = nil,
         imageURL: String? = nil,
         overview: String? = nil,
         cast: [Cast]? = nil,
         director: Director? = nil,
         releaseDate: String? = nil) {

        self.uuid = UUID()
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.rating = rating
        self.genres = genres
        self.imageURL = imageURL
        self.overview = overview
        self.cast = cast
        self.director = director
        self.releaseDate = releaseDate
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
        hasher.combine(id)
        hasher.combine(title)
    }
}
