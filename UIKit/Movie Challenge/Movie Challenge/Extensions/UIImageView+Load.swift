//
//  UIImageView+Load.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 21/06/22.
//

import UIKit

extension UIImageView {

    func loadFrom(url: String) {

        guard let url = URL(string: url) else {
            return
        }

        DispatchQueue.global().async {

            if let data = try? Data(contentsOf: url) {

                DispatchQueue.main.async { [weak self] in
                    self?.image = UIImage(data: data)
                }
            }
        }
    }
}
