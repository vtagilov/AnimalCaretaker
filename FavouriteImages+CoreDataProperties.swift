//
//  FavouriteImages+CoreDataProperties.swift
//  AnimalCaretaker
//
//  Created by Владимир on 26.06.2023.
//
//

import Foundation
import CoreData


extension FavouriteImages {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavouriteImages> {
        return NSFetchRequest<FavouriteImages>(entityName: "FavouriteImages")
    }

    @NSManaged public var url: URL?
    @NSManaged public var data: Data?

}

extension FavouriteImages : Identifiable {

}
