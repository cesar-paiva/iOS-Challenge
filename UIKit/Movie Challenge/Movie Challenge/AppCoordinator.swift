//
//  AppCoordinator.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 21/06/22.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController : UINavigationController { get set }

    func start()
    func childDidFinish(_ child: Coordinator?)
}

extension Coordinator {

    func childDidFinish(_ child: Coordinator?) {

        for (index, coordinator) in childCoordinators.enumerated() {

            if coordinator === child {

                childCoordinators.remove(at: index)
                break
            }
        }
    }
}

class AppCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController

    init(withNavigationController navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {

        let moviesCoordinator = HomeCoordinator(withNavigationController: navigationController)
        moviesCoordinator.start()
    }
}
