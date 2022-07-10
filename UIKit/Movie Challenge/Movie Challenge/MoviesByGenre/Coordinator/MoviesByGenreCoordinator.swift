//
//  MoviesByGenreCoordinator.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 24/06/22.
//

import UIKit

class MoviesByGenreCoordinator: Coordinator {

    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var genre: String

    init(withNavigationController navigationController: UINavigationController,
         genre: String) {
        self.navigationController = navigationController
        self.genre = genre
    }

    func start() {

        let viewModel = MoviesByGenreViewModel(genre: genre)
        let moviesByGenreViewController = MoviesByGenreViewController(viewModel: viewModel)
        moviesByGenreViewController.coordinator = self
        navigationController.pushViewController(moviesByGenreViewController, animated: true)
    }
}

extension MoviesByGenreCoordinator {

    func showMovieDetails(with id: Int) {

        let movieDetailsCoordinator = MovieDetailsCoordinator(withNavigationController: navigationController,
                                                              movieId: id)
        childCoordinators.append(movieDetailsCoordinator)
        movieDetailsCoordinator.parentCoordinator = self
        movieDetailsCoordinator.start()
    }

    func didFinishShowMovieByGenre() {
        parentCoordinator?.childDidFinish(self)
    }
}
