import Foundation
import UIKit


class NetworkManager {
    
    var models = [AnimalModel]()
    var animalType: AnimalType!
    var delegate: NetworkProtocol?
    let getModelsSemaphore = DispatchSemaphore(value: 0)
    
    
    
    init(_ animalType: AnimalType) {
        self.animalType = animalType
    }
    
    
    
    func loadCell() {
        DispatchQueue.global(qos: .utility).async {
            if self.models.count < 5 {
                self.getAnimalModels()
                self.getModelsSemaphore.wait()
            }
            for _ in 0...3 {
                guard let animalModel = self.models.first else {
                    self.loadCell()
                    return
                }
                guard let url = URL(string: animalModel.url) else {
                    self.uploadError(.urlParsingError)
                    return
                }
                self.loadImage(url, animalModel.id)
                self.models.removeFirst()
            }
        }
    }
        
    
    
    private func getAnimalModels() {
        let url = getAnimalModelRequestURL()
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, responce, error in
            
            if let error = error {
                self.delegate?.loadError(error)
                return
            }
            
            guard let data = data else {
                self.delegate?.loadError(CustomError.networkError)
                return
            }
            
            let animalModels = try? JSONDecoder().decode([AnimalModel].self, from: data)
            
            guard let animalModels = animalModels else {
                self.getAnimalModels()
                return
            }
            
            for animalModel in animalModels {
                self.models.append(animalModel)
            }
            self.getModelsSemaphore.signal()
        }.resume()
        
        
    }
    
    
    private func loadImage(_ url: URL, _ id: String) {
        DispatchQueue.global(qos: .unspecified).async {
            let data = try? Data(contentsOf: url)
            guard let data = data else {
                self.uploadError(.networkError)
                return
            }
            if let image = UIImage.gif(data: data) {
                self.uploadAnimalModel(id, image)
                return
            }
            guard let image = UIImage(data: data) else {
                self.uploadError(.imageParsingError)
                return
            }
            self.uploadAnimalModel(id, image)
        }
    }
    
    
    private func uploadError(_ error: CustomError) {
        self.delegate?.loadError(error)
    }
    
    
    private func uploadAnimalModel(_ id: String, _ image: UIImage) {
        let animalModel = AnimalCellModel(id: id, image: image)
        DispatchQueue.main.async {
            self.delegate?.addAnimalModel(animalModel)
        }
    }
    
    
    private func getAnimalModelRequestURL() -> URL {
        var url: URL
        switch animalType {
        case .dogs:
            url = URL(string: "https://api.thedogapi.com/v1/images/search?limit=3")!
        case .cats:
            url = URL(string: "https://api.thecatapi.com/v1/images/search?limit=3")!
        case .none:
            url = URL(string: "https://api.thedogapi.com/v1/images/search?limit=3")!
        }
        return url
    }
    
}
