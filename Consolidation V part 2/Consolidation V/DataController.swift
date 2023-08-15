//
//  DataController.swift
//  Consolidation V
//
//  Created by Pedro Pablo on 11/08/23.
//

import CoreData
import Foundation


class DataControler: ObservableObject {
    let container = NSPersistentContainer(name: "CoreDataUser")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
                return
            }
//            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
    
}
