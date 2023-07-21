//
//  DetailActivity.swift
//  Consolidation IV
//
//  Created by Pedro Pablo on 18/07/23.
//

import SwiftUI

struct DetailActivity: View {
    var item: ActivityItem
    @ObservedObject var activities: Activities
    @State var counter: Int
    @State var listDates: [Date]
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(0 ..< listDates.count, id: \.self) {index in
                    HStack {
                        Text(activities.formattedDate(listDates[index]))
                    }
                    .frame(maxWidth: .infinity, minHeight: 30, alignment: .leading)
                    .padding(.horizontal)
                }
            }
            .navigationTitle("\(item.title) | \(counter)")//Image(systemName: "\(counter).circle.fill")
            .toolbar {
                Button {
                    counter = activities.increaseCounter(activity: item)
                    let index = activities.getIndex(activity: item)
                    listDates = activities.items[index].completedList
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
    
}

struct DetailActivity_Previews: PreviewProvider {
    static var previews: some View {
        DetailActivity(item: ActivityItem(title: "Titulo", description: "Descrp"),
                       activities: Activities(), counter: 0, listDates: [Date()])
    }
}
