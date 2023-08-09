//
//  ContentView.swift
//  Project 12 challenge
//
//  Created by Pedro Pablo on 7/08/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    let listFilters = ["firstName", "lastName"]
    @State private var nameFilter = "firstName"
    @State private var search = ""
    
    var body: some View {
        VStack {
            Picker("Filter by:", selection: $nameFilter) {
                ForEach(listFilters, id: \.self) {
                    Text("\($0)")
                }
            }
            Text("Showing: \(search)")
            FilterList(search: search, filter: nameFilter, sortDescription: [SortDescriptor(\.firstName)])
            
            Button("Add Examples") {
                let taylor = Singer(context: moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"
                
                let ed = Singer(context: moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"
                
                let adele = Singer(context: moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"
                
                try? moc.save()
            }
            if nameFilter == "firstName" {
                Button("Show A") {
                    search = "A"
                }
                Button("Show E") {
                    search = "E"
                }
                Button("Show T") {
                    search = "T"
                }
            } else {
                Button("Show S") {
                    search = "S"
                }
                Button("Show A") {
                    search = "A"
                }
            }
            Button("Show All") {
                search = ""
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
