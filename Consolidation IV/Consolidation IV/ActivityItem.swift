//
//  ActivityItem.swift
//  Consolidation IV
//
//  Created by Pedro Pablo on 18/07/23.
//

import Foundation

struct ActivityItem: Identifiable ,Codable, Equatable {
    static func == (lhs: ActivityItem, rhs: ActivityItem) -> Bool {
        return lhs.id == rhs.id
    }

    let id = UUID()
    var title: String
    var description: String
    var counter_completed: Int = 0
    var completedList = [Date]()
    
}
