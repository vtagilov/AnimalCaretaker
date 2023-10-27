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

struct PostModel {
    let id: Int
    let data: Data
    let time: Date
}


enum AnimalType {
    case cats
    case dogs
}

