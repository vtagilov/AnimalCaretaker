//
//  Erorrs.swift
//  AnimalCaretaker
//
//  Created by Владимир on 12.09.2023.
//

import Foundation


enum CustomError: Error {
    case networkError
    case invalidInput
    case imageParsingError
    case animalModelParsingError
    case urlParsingError
}

