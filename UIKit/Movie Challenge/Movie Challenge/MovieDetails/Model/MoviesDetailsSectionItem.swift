//
//  MoviesDetailsSectionItem.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 25/06/22.
//

import Foundation

struct MoviesDetailsSectionItem: Codable, Hashable {

    var uuid = UUID()
    let id: Int?
    let title: String?
    let rating: String?
    let genres: String?
    let director: String?
    let imageURL: String?
    let overview: String?

    init(uuid: UUID = UUID(), id: Int? = nil,
         title: String? = nil,
         rating: String? = nil,
         genres: String? = nil,
         director: String? = nil,
         imageURL: String? = nil,
         overview: String? = nil) {
        self.uuid = uuid
        self.id = id
        self.title = title
        self.rating = rating
        self.genres = genres
        self.director = director
        self.imageURL = imageURL
        self.overview = overview
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
