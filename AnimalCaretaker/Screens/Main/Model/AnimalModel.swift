//
//  AnimalModel.swift
//  AnimalCaretaker
//
//  Created by Владимир on 08.09.2023.
//

import UIKit


struct AnimalModel: Codable {
    let id: String
    let url: String
    let width: Int
    let height: Int
}

struct AnimalCellModel {
    let id: String
    let image: UIImage
    let data: Data
}


enum AnimalType {
    case cats
    case dogs
}

