//
//  View.swift
//  AnimalCaretaker
//
//  Created by Владимир on 10.10.2023.
//

import Foundation
import UIKit

extension UIView {
    func setGradient() {
        let gradientLayer = CAGradientLayer()
        let startColour = UIColor(red: 253 / 255, green: 246 / 255, blue: 244 / 255, alpha: 1.0).cgColor
        let endColour = UIColor(red: 239 / 255, green: 250 / 255, blue: 248 / 255, alpha: 1.0).cgColor
        gradientLayer.colors = [startColour, endColour]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
