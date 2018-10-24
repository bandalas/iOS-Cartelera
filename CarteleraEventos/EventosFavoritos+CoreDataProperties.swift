//
//  EventosFavoritos+CoreDataProperties.swift
//  
//
//  Created by Esteban Arocha Ortuño on 4/6/18.
//
//

import Foundation
import CoreData


extension EventosFavoritos {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EventosFavoritos> {
        return NSFetchRequest<EventosFavoritos>(entityName: "EvenFavoritos")
    }

    @NSManaged public var ident: Int32

}
