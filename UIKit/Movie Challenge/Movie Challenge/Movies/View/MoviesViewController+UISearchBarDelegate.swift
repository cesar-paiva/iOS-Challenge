//
//  MoviesViewController+UISearchBarDelegate.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 26/06/22.
//

import UIKit

extension MoviesViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        performQuery(with: searchText)
    }
}
