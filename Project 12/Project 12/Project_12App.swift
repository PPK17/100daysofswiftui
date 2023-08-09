//
//  Project_12App.swift
//  Project 12
//
//  Created by Pedro Pablo on 3/08/23.
//

import SwiftUI

@main
struct Project_12App: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
