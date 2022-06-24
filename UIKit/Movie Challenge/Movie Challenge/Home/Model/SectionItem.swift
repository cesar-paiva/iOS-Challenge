//
//  SectionItem.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 23/06/22.
//

import Foundation

struct SectionItem: Codable, Hashable {

    let id: UUID
    let title: String?
    let subtitle: String?
    let rating: Double?
    let imageName: String?

    init(id: UUID, title: String? = nil, subtitle: String? = nil, rating: Double? = nil, imageName: String? = nil) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.rating = rating
        self.imageName = imageName
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func ==(lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id &&
            lhs.title == rhs.title &&
            lhs.subtitle == rhs.subtitle &&
            lhs.imageName == rhs.imageName
    }

}
