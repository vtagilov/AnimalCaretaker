import Foundation
import UIKit


protocol NetworkProtocol {
    func addAnimalModel(_ animalModel: AnimalCellModel)
    func loadError(_ error: Error)
}

