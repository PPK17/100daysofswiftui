//
//  Consolidation_VApp.swift
//  Consolidation V
//
//  Created by Pedro Pablo on 9/08/23.
//

import SwiftUI

@main
struct Consolidation_VApp: App {
    @StateObject var dataController = DataControler()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
