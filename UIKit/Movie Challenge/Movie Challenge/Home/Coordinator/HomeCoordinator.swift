//
//  HomeCoordinator.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 22/06/22.
//

import UIKit

class HomeCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    init(withNavigationController navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {

        let homeViewController = HomeViewController()
        homeViewController.coordinator = self
        navigationController.pushViewController(homeViewController, animated: true)
    }
}

extension HomeCoordinator {

    func showMovies(of genre: String) {

        let moviesByGenreCoordinator = MoviesByGenreCoordinator(withNavigationController: navigationController,
                                                                genre: genre)
        moviesByGenreCoordinator.parentCoordinator = self
        childCoordinators.append(moviesByGenreCoordinator)
        moviesByGenreCoordinator.start()
    }

    func showAllMovies() {

        let moviesCoordinator = MoviesCoordinator(withNavigationController: navigationController)
        moviesCoordinator.parentCoordinator = self
        childCoordinators.append(moviesCoordinator)
        moviesCoordinator.start()
    }

    func showMovieDetails(of movie: Movie) {

        let movieDetailsCoordinator = MovieDetailsCoordinator(withNavigationController: navigationController,
                                                              movie: movie)
        movieDetailsCoordinator.parentCoordinator = self
        childCoordinators.append(movieDetailsCoordinator)
        movieDetailsCoordinator.start()
        
    }
}
