//
//  UIViewController+Modal.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 26/06/22.
//

import UIKit

extension UIViewController {

    func presentModal(withImageURL url: String) {

        let viewController = UIViewController()
        viewController.view.backgroundColor = .black

        let imageView = UIImageView(frame: viewController.view.frame)
        imageView.contentMode = .center

        imageView.loadFrom(url: url)

        viewController.view.addSubview(imageView)

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissModal))
        viewController.view.addGestureRecognizer(tapGestureRecognizer)

        viewController.modalPresentationStyle = .overFullScreen
        self.navigationController?.present(viewController, animated: true)
    }

    @objc
    func dismissModal() {
        navigationController?.dismiss(animated: true)
    }
}
