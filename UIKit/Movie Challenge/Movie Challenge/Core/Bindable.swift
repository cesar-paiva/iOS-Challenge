//
//  Bindable.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 21/06/22.
//

import Foundation

class Bindable<T> {

    private var listener: ((T?) -> Void)?

    var value: T? {
        didSet {
            DispatchQueue.main.async {
                self.listener?(self.value)
            }
        }
    }

    init(_ value: T?) {
        self.value = value
    }

    func bind(_ listener: @escaping (T?) -> Void) {

        listener(value)
        self.listener = listener
    }
}
