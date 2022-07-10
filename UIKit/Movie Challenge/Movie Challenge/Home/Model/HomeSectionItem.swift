//
//  SectionItem.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 23/06/22.
//

import Foundation

enum HomeSectionItem: Hashable {
    case topMovies(Movie)
    case allMovies(Movie)
    case genres(String)
}
