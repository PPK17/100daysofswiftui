//
//  CacheFriend+CoreDataProperties.swift
//  Consolidation V
//
//  Created by Pedro Pablo on 11/08/23.
//
//

import Foundation
import CoreData


extension CacheFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CacheFriend> {
        return NSFetchRequest<CacheFriend>(entityName: "CacheFriend")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var user: CacheUser?
    
    var wrappedName: String {
        name ?? "Unknown"
    }

}

extension CacheFriend : Identifiable {

}
