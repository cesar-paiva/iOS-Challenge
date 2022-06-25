//
//  HomeViewControllerCoordinator.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 24/06/22.
//

import Foundation

protocol HomeViewControllerCoordinator {
    func showMovies(of genre: String)
    func showAllMovies()
}
