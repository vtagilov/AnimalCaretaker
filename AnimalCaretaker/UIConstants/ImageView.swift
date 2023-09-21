//
//  ImageView.swift
//  AnimalCaretaker
//
//  Created by Владимир on 20.09.2023.
//

import Foundation
import UIKit

extension UIImageView {
    func makeProfileImage() {
        self.layer.cornerRadius = 50
        self.layer.borderColor = UIColor.white.cgColor
        self.clipsToBounds = true
        self.layer.borderWidth = 3
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let profileImageData = ProfileManager().getImageData()
        if let profileImageData = profileImageData {
            self.image = UIImage(data: profileImageData)
        } else {
            self.image = UIImage(systemName: "person.crop.circle.fill")!.withRenderingMode(.automatic)
            self.tintColor = .white
        }
    }
}
