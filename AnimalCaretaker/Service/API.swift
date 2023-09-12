//
//  API.swift
//  AnimalCaretaker
//
//  Created by Владимир on 08.09.2023.
//

import Foundation

struct AnimalAPI {
    var animalType: AnimalTypes!
    var imageURLs = [URL]()
    private let queue = DispatchQueue(label: "FisrtQueue", attributes: .concurrent)
    private let group = DispatchGroup()
    var delegate: NetworkProtocol?
    let semaphore = DispatchSemaphore(value: 0)
    
    
    init(_ animalType: AnimalTypes) {
        self.animalType = animalType
        getUrls(self.animalType)
        
    }
    
    
    func getUrls(_ animalType: AnimalTypes) {
        let url: URL!
        
        switch animalType {
        case .dogs:
            url = URL(string: "https://api.thedogapi.com/v1/images/search?limit=10")!
        case .cats:
            url = URL(string: "https://api.thecatapi.com/v1/images/search?limit=10")!
        }
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            let data = try? Data(contentsOf: url)
            guard let data = data else { print("getUrls: Network problems"); return }
            let objects = try? JSONDecoder().decode([AnimalStruct].self, from: data)
            guard let objects = objects else { print("getUrls: Decode problems"); return }
            
            for obj in objects {
                let objURL = URL(string: obj.url)!
                self.imageURLs.append(objURL)
                self.semaphore.signal()
            }
        }
    }
    
    
    func loadImage() {
        
        
        if imageURLs.count < 5 {
            getUrls(self.animalType)
        }
        
        if imageURLs.isEmpty {
            semaphore.wait()
        }
        
        var url: URL!
        if self.imageURLs.first != nil {
            url = self.imageURLs.first!
            imageURLs.removeFirst()
        } else {
            return
        }
        
        
        queue.async {
            let data = try? Data(contentsOf: url)
            guard let data = data else { print("loadImage: Network Error"); return }
            let image = UIImage.gif(data: data)
            guard let image = image else { print("loadImage: Decoder Error"); return }
            DispatchQueue.main.async {
                self.delegate?.addTableCell(with: image)
            }
        }
        
        
    }
    
    
}



