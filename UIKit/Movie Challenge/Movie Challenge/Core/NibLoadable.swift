//
//  NibLoadable.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 26/06/22.
//

import UIKit

protocol NibLoadable: AnyObject {
    static var nib: UINib { get }
}

extension NibLoadable {

    static var nib: UINib {
        UINib(nibName: String(describing: self), bundle: Bundle(for: self))
    }

}
