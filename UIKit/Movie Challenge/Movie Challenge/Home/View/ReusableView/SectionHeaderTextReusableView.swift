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
        
    @IBOutlet weak var titleLabel: UILabel!
}
