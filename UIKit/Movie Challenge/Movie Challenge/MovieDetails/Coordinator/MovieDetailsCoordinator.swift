//
//  MovieDetailsCoordinator.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 24/06/22.
//

import UIKit

class MovieDetailsCoordinator: Coordinator {

    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var movieId: Int

    init(withNavigationController navigationController: UINavigationController,
         movieId: Int) {
        self.navigationController = navigationController
        self.movieId = movieId
    }

    func start() {

        let moviesViewController = MovieDetailsViewController(movieId: movieId)
        moviesViewController.coordinator = self
        navigationController.pushViewController(moviesViewController, animated: true)
    }

    func didFinishShowMovieDetails() {
        parentCoordinator?.childDidFinish(self)
    }
}
