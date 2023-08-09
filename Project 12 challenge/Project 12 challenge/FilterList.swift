//
//  FilterList.swift
//  Project 12 challenge
//
//  Created by Pedro Pablo on 7/08/23.
//

import CoreData
import SwiftUI

enum FilterPredicate: String {
    case beginWith = "BEGINSWITH[c]"
}


struct FilterList : View {
    @FetchRequest var fetchRequest: FetchedResults<Singer>

    var body: some View {
        List(fetchRequest, id: \.self) {singer in
            Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
        }
    }

    init(search: String, filter: String = "lastName", sortDescription: [SortDescriptor<Singer>] = []) {
        if String(search).trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            _fetchRequest = FetchRequest<Singer>(sortDescriptors: sortDescription, predicate: NSPredicate(format: "NOT %K %s %@".replacingOccurrences(of: "%s", with: FilterPredicate.beginWith.rawValue), filter, search))
        } else {
            _fetchRequest = FetchRequest<Singer>(sortDescriptors: sortDescription, predicate: NSPredicate(format: "%K %s %@".replacingOccurrences(of: "%s", with: FilterPredicate.beginWith.rawValue), filter, search))
        }
    }

}
