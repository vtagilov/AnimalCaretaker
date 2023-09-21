//
//  TextField.swift
//  AnimalCaretaker
//
//  Created by Владимир on 20.09.2023.
//

import Foundation
import UIKit

extension UITextField {
    func makeProfileNameField(_ size: CGFloat) {
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        self.smartQuotesType = .no
        self.smartDashesType = .no
        self.font = .boldSystemFont(ofSize: size)
        self.textAlignment = .center
        self.text = ProfileManager().getName()
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
