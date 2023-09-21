//
//  ProfileManager.swift
//  AnimalCaretaker
//
//  Created by Владимир on 19.09.2023.
//

import Foundation

class ProfileManager {
    
    func saveName(_ name: String) {
        let defaults = UserDefaults.standard
        defaults.set(name, forKey: "UserName")
    }
    
    
    func getName() -> String {
        let defaults = UserDefaults.standard
        if let name = defaults.string(forKey: "UserName") {
            return name
        } else {
            return "Username"
        }
    }
    
    
    func saveImageData(_ imageData: Data) {
        let defaults = UserDefaults.standard
        defaults.set(imageData, forKey: "UserProfileImage")
    }
    
    
    func getImageData() -> Data? {
        let defaults = UserDefaults.standard
        if let userProfileImage = defaults.data(forKey: "UserProfileImage") {
            return userProfileImage
        } else {
            return nil
        }
    }
}
