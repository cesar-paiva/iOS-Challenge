//
//  SectionHeaderTextReusableView.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 23/06/22.
//

import UIKit

class SectionHeaderTextReusableView: UICollectionReusableView {
    
    static var nib: UINib {
        UINib(nibName: String(describing: Self.self), bundle: nil)
    }
        
    @IBOutlet weak private(set) var titleLabel: UILabel!
    @IBOutlet weak private(set) var button: UIButton!
    @IBOutlet weak private(set) var contentView: UIView!

    var action: (() -> Void)?

    func setup(title: String,
               isHiddenButton: Bool = true,
               buttonTitle: String? = nil) {

        titleLabel.text = title
        button.isHidden = isHiddenButton
        button.setTitle(buttonTitle, for: .normal)
    }

    @objc
    func touchUpInside() {
        action?()
    }

    func buttonActionHandler(action: @escaping () -> Void) {
        self.action = action
        button.addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
    }

    func setupBackgroundColor(_ color: UIColor) {
        contentView.backgroundColor = color
    }

    func setupTitleColor(_ color: UIColor) {
        titleLabel.textColor = color
    }
}
