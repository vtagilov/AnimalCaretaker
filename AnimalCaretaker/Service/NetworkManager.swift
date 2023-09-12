import Foundation
import UIKit


class NetworkManager {
    
    var animalType: AnimalType!
    var delegate: NetworkProtocol?
    
    
    init(_ animalType: AnimalType) {
        self.animalType = animalType
    }
    
    
    func getUrls() {
        let url: URL!
        
        switch animalType {
        case .dogs:
            url = URL(string: "https://api.thedogapi.com/v1/images/search?limit=3")!
        case .cats:
            url = URL(string: "https://api.thecatapi.com/v1/images/search?limit=3")!
        case .none:
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, responce, error in
            
            if let error = error {
                self.delegate?.loadError(error)
                return
            }
            
            guard let data = data else {
                self.delegate?.loadError("data is empty" as! Error)
                return
            }
            
            let animalModels = try? JSONDecoder().decode([AnimalModel].self, from: data)
            
            guard let animalModels = animalModels else {
                self.delegate?.loadError("wrong Animal Model" as! Error)
                return
            }
            
            for animalModel in animalModels {
                guard let url = URL(string: animalModel.url) else {
                    self.delegate?.loadError("wrong image url" as! Error)
                    return
                }
                self.loadImage(url, animalModel.id)
            }
            
        }.resume()
    }
    
    
    func loadImage(_ url: URL, _ id: String) {
        DispatchQueue.global(qos: .unspecified).async {
            let data = try? Data(contentsOf: url)
            guard let data = data else {
                self.delegate?.loadError("image url didn't loading" as! Error)
                return
            }
            guard let image = UIImage(data: data) else {
                self.delegate?.loadError("image cannot convert" as! Error)
                return
            }
            
            let animalModel = AnimalCellModel(id: id, image: image)
            DispatchQueue.main.async {
                self.delegate?.addAnimalModel(animalModel)
            }
        }
    }
    
}
