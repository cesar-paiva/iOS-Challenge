//
//  Section.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 23/06/22.
//

import Foundation

struct Section<T> {

    let title: String
    let layout: T
    let items: [SectionItem]
}
