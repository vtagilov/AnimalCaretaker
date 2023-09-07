import Foundation
import UIKit

class CoreDataManager {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var favouriteImages =  [UIImage]()
    
    
    
    init() {
        reloadImages()
        deleteAllImages()
    }
    
    
    
    func addImage(_ image: UIImage) {
        let newItem = FavouriteImages(context: context)
        
        newItem.data = image.pngData()
        
        do {
            try context.save()
            
            favouriteImages.append(image)
        } catch {
            print("ERROR: CoreDataManager/addImage()")
        }
    }
    
    
    
    func removeImage(_ image: UIImage) {
        do {
            let items = try context.fetch(FavouriteImages.fetchRequest())
            
            for item in items {
                
                if item.data == image.pngData() {
                    context.delete(item)
                }
            }
            print("favouriteImages.count ", favouriteImages.count)
            for i in 0 ..< favouriteImages.count {
                print(i)
                if favouriteImages[i].pngData() == image.pngData() {
                    favouriteImages.remove(at: i)
                }
            }
        }
        catch {
            print("ERROR: CoreDataManager/removeImage()")
        }
    }
    
    
    
    
    
    func reloadImages() {
        favouriteImages = []
        
        do {
            let items = try context.fetch(FavouriteImages.fetchRequest())
            
            for item in items {
                if item.data == nil {
                    context.delete(item)
                    try context.save()
                    continue
                }
                favouriteImages.append(UIImage(data: item.data!)!)
            }
            
        }
        catch {
            print("ERROR: CoreDataManager/removeImage()")
        }
    }
    
    
    
    func deleteAllImages() {
        for image in favouriteImages {
            removeImage(image)
        }
        favouriteImages = []
        print(favouriteImages.count)
    }
    
}
