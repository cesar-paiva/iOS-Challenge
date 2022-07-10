//
//  MoviesCoordinator.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 24/06/22.
//

import UIKit

class MoviesCoordinator: Coordinator {

    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    init(withNavigationController navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {

        let moviesViewController = MoviesViewController()
        moviesViewController.coordinator = self
        navigationController.pushViewController(moviesViewController, animated: true)
    }
}

extension MoviesCoordinator {

    func showMovieDetails(with id: Int) {

        let movieDetailsCoordinator = MovieDetailsCoordinator(withNavigationController: navigationController,
                                                              movieId: id)
        childCoordinators.append(movieDetailsCoordinator)
        movieDetailsCoordinator.parentCoordinator = self
        movieDetailsCoordinator.start()
    }

    func didFinishShowMovies() {
        parentCoordinator?.childDidFinish(self)
    }
}
