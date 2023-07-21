//
//  AddActivity.swift
//  Consolidation IV
//
//  Created by Pedro Pablo on 18/07/23.
//

import SwiftUI

struct AddActivity: View {
    @ObservedObject var activities: Activities
    @Environment(\.dismiss) var dismiss
    @State var title: String = ""
    @State var description: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $title)
                TextField("Description", text: $description)
            }
            .navigationTitle("New activity")
            .toolbar {
                Button("Save") {
                    let item = ActivityItem(title: title, description: description)
                    activities.items.append(item)
                    dismiss()
                    
                }
            }
        }
    }
}

struct AddActivity_Previews: PreviewProvider {
    static var previews: some View {
        AddActivity(activities: Activities())
    }
}
