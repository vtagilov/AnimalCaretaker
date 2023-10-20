//
//  LikeManager.swift
//  AnimalCaretaker
//
//  Created by Владимир on 15.09.2023.
//

import Foundation
import CoreData
import UIKit


class LikeManager {
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context: NSManagedObjectContext!
    private var savedModels: [(id: String, data: Data)] = []
    var likedIds = [String]()
    
    
    
    init() {
        context = appDelegate.persistentContainer.viewContext
        reloadModels()
    }
    
    
    
    func getModels() -> [AnimalCellModel] {
        reloadModels()
        var cellModels = [AnimalCellModel]()
        for model in savedModels {
            
            if let image = UIImage.gif(data: model.data) {
                cellModels.append(AnimalCellModel(id: model.id, image: image, data: model.data))
            } else {
                let image = UIImage(data: model.data)!
                cellModels.append(AnimalCellModel(id: model.id, image: image, data: model.data))
            }
        }
        return cellModels
    }
    
    
    
    private func reloadModels() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        do {
            let result = try context.fetch(fetchRequest)
            if let entities = result as? [NSManagedObject] {
                savedModels = []
                for entity in entities {
                    if let id = entity.value(forKey: "id") as? String,
                       let imageData = entity.value(forKey: "imageData") as? Data {
                        savedModels.append((id, imageData))
                        likedIds.append(id)
                    }
                }
            }
        } catch {
            print("Ошибка при получении данных из Core Data: \(error)")
        }
    }
    
    
    
    func isLiked(_ model: AnimalCellModel) -> Bool {
        likedIds.contains(model.id)
    }
    
    
    
    func addLike(_ model: AnimalCellModel) {
        if let entity = NSEntityDescription.entity(forEntityName: "Entity", in: context) {
            let object = NSManagedObject(entity: entity, insertInto: context)
            object.setValue(model.id, forKey: "id")
            object.setValue(model.data, forKey: "imageData")
            do {
                try context.save()
                likedIds.append(model.id)
            } catch {
                print("Ошибка при сохранении данных: \(error)")
            }
        }
    }
    
    
    
    func removeLike(_ model: AnimalCellModel) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Entity")
        fetchRequest.predicate = NSPredicate(format: "id == %@", model.id)

        do {
            let result = try context.fetch(fetchRequest)
            if let entities = result as? [NSManagedObject] {
                for entity in entities {
                    context.delete(entity)
                }
                do {
                    try context.save()
                    likedIds.removeAll(where: { $0 == model.id })
                } catch {
                    print("Ошибка при сохранении после удаления: \(error)")
                }
            }
        } catch {
            print("Ошибка при получении данных из Core Data: \(error)")
        }
    }
    
    

}
