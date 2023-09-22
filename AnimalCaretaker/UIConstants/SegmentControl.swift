//
//  SegmentControl.swift
//  AnimalCaretaker
//
//  Created by Владимир on 21.09.2023.
//

import Foundation
import UIKit

extension UISegmentedControl {
    func makeProfileControl() {
        self.insertSegment(withTitle: "My Post", at: 0, animated: true)
        self.insertSegment(withTitle: "Liked", at: 1, animated: true)
        self.selectedSegmentIndex = 0
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
