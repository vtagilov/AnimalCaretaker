//
//  PostsManager.swift
//  AnimalCaretaker
//
//  Created by Владимир on 23.10.2023.
//

import Foundation
import UIKit
import CoreData

class PostsManager {
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context: NSManagedObjectContext!
    private var models: [(id: Int, data: Data, time: Date)] = []
    var postsIds = [Int]()
    
    
    
    init() {
        context = appDelegate.persistentContainer.viewContext
        reloadModels()
    }
    
    
    
    func getModels() -> [PostModel] {
        reloadModels()
        var postModels = [PostModel]()
        for model in models {
            postModels.append(PostModel(id: model.id, data: model.data, time: model.time))
        }
        return postModels
    }
    
    
    
    private func reloadModels() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UploadPosts")
        do {
            let result = try context.fetch(fetchRequest)
            if let entities = result as? [NSManagedObject] {
                models = []
                for entity in entities {
                    if let id = entity.value(forKey: "id") as? Int,
                       let imageData = entity.value(forKey: "imageData") as? Data,
                       let time = entity.value(forKey: "time") as? Date {
                        models.append((id, imageData, time))
                        postsIds.append(id)
                    }
                }
            }
        } catch {
            print("Ошибка при получении данных из Core Data: \(error)")
        }
    }
    
    
    
    func addPost(_ model: PostModel) {
        if let entity = NSEntityDescription.entity(forEntityName: "UploadPosts", in: context) {
            let object = NSManagedObject(entity: entity, insertInto: context)
            let data = compressImageData(model.data)
            object.setValue(model.id, forKey: "id")
            object.setValue(data, forKey: "imageData")
            object.setValue(model.time, forKey: "time")
            do {
                try context.save()
                postsIds.append(model.id)
            } catch {
                print("Ошибка при сохранении данных: \(error)")
            }
        }
    }
    
    
    
    func removePost(_ model: PostModel) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UploadPosts")
        fetchRequest.predicate = NSPredicate(format: "id == %@", model.id)
        
        do {
            let result = try context.fetch(fetchRequest)
            if let entities = result as? [NSManagedObject] {
                for entity in entities {
                    context.delete(entity)
                }
                do {
                    try context.save()
                    postsIds.removeAll(where: { $0 == model.id })
                } catch {
                    print("Ошибка при сохранении после удаления: \(error)")
                }
            }
        } catch {
            print("Ошибка при получении данных из Core Data: \(error)")
        }
    }
    
    
    private func compressImageData(_ data: Data) -> Data {
        if let image = UIImage(data: data) {
            guard let data = image.jpegData(compressionQuality: 1.0) else {
                return Data()
            }
            
            let dataCount = data.count
            let maxCount = 1000000
            let multiplayer: CGFloat = CGFloat(maxCount) / CGFloat(dataCount) / 5
            
            if let compressedImageData = image.jpegData(compressionQuality: multiplayer) {
                return compressedImageData
            }
        }
        return Data()
    }
    
}
