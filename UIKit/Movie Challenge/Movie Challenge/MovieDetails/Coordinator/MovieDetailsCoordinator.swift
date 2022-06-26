//
//  MovieDetailsCoordinator.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 24/06/22.
//

import UIKit

protocol MovieDetailsCoordinatorProtocol: AnyObject {
    func showMovieDetails(of movie: Movie)
}

class MovieDetailsCoordinator: Coordinator {

    weak var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var movie: Movie

    init(withNavigationController navigationController: UINavigationController,
         movie: Movie) {
        self.navigationController = navigationController
        self.movie = movie
    }

    func start() {

        let viewModel = MovieDetailsViewModel(movie: movie)
        let moviesViewController = MovieDetailsViewController(viewModel: viewModel)
        navigationController.pushViewController(moviesViewController, animated: true)
    }

    func didFinishShowMovieDetails() {
        parentCoordinator?.childDidFinish(self)
    }
}
