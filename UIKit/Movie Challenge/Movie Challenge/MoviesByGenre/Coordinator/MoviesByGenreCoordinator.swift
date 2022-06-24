//
//  MoviesByGenreCoordinator.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 24/06/22.
//

import UIKit

class MoviesByGenreCoordinator: Coordinator {

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
        navigationController.pushViewController(moviesByGenreViewController, animated: true)
    }
}
