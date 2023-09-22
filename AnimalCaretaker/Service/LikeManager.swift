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
            let image = UIImage(data: model.data)!
            cellModels.append(AnimalCellModel(id: model.id, image: image))
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
        if likedIds.contains(model.id) {
            return true
        }
        return false
    }
    
    func addLike(_ model: AnimalCellModel) {
        if let entity = NSEntityDescription.entity(forEntityName: "Entity", in: context) {
            let object = NSManagedObject(entity: entity, insertInto: context)
            object.setValue(model.id, forKey: "id")
            object.setValue(model.image.pngData(), forKey: "imageData")
            do {
                try context.save()
                print("Данные успешно сохранены.")
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
                    print("Объекты успешно удалены.")
                } catch {
                    print("Ошибка при сохранении после удаления: \(error)")
                }
            }
        } catch {
            print("Ошибка при получении данных из Core Data: \(error)")
        }
    }
    
    

}
