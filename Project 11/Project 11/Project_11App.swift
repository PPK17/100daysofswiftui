//
//  Project_11App.swift
//  Project 11
//
//  Created by Pedro Pablo on 26/07/23.
//

import SwiftUI

@main
struct Project_11App: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)// Que tenga en cuenta el data model al grabar/leer
        }
    }
}
