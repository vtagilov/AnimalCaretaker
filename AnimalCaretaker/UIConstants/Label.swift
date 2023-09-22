//
//  Label.swift
//  AnimalCaretaker
//
//  Created by Владимир on 21.09.2023.
//

import Foundation
import UIKit

extension UILabel {
    func makeCounerLabel() {
        self.numberOfLines = 2
        self.textAlignment = .center
        self.textColor = .lightGray
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
