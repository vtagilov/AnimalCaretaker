//
//  Label.swift
//  AnimalCaretaker
//
//  Created by Владимир on 21.09.2023.
//

import Foundation
import UIKit

extension UILabel {
    static func makeCounterLabel() -> UILabel {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = .lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    static func makeTitleLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 32)
        label.text = text
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}
