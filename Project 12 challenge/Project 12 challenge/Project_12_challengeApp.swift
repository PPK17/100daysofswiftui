//
//  Project_12_challengeApp.swift
//  Project 12 challenge
//
//  Created by Pedro Pablo on 7/08/23.
//

import SwiftUI

@main
struct Project_12_challengeApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
