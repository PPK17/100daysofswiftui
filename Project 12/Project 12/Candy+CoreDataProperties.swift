//
//  Candy+CoreDataProperties.swift
//  Project 12
//
//  Created by Pedro Pablo on 4/08/23.
//
//

import Foundation
import CoreData


extension Candy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Candy> {
        return NSFetchRequest<Candy>(entityName: "Candy")
    }

    @NSManaged public var name: String?
    @NSManaged public var origin: Country?
    
    var wrappedName: String {
        name ?? "Unknown"
    }

}

extension Candy : Identifiable {

}
