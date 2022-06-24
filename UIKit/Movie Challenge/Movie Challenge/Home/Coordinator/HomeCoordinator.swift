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
        navigationController.pushViewController(homeViewController, animated: true)
    }
}
