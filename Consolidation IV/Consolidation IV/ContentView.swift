//
//  ContentView.swift
//  Consolidation IV
//
//  Created by Pedro Pablo on 18/07/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var activities = Activities()
    @State private var showingAddActivity = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(activities.items) { item in
                    NavigationLink {
                        DetailActivity(item: item, activities: activities,
                                       counter: item.counter_completed,
                                       listDates: item.completedList)
                    } label: {
                        VStack {
                            HStack {
                                Text(item.title)
                                    .font(.headline)
                                    .padding()
                                VStack(alignment: .leading) {
                                    Text(item.description)
                                    Text("\(item.counter_completed) completed")
                                }
                                .frame(maxWidth: .infinity)
                            }
                            .padding(.leading)
                        }
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("Habit-tracking")
            .toolbar {
                Button {
                    showingAddActivity = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddActivity) {
                AddActivity(activities: activities)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        activities.items.remove(atOffsets: offsets)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
