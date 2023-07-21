//
//  Activity.swift
//  Consolidation IV
//
//  Created by Pedro Pablo on 18/07/23.
//

import Foundation

class Activities: ObservableObject {
    @Published var items = [ActivityItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let itemsSaved = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ActivityItem].self, from: itemsSaved) {
                self.items = decodedItems
                return
            }
        }
    }
    
    
    func getIndex(activity: ActivityItem) -> Int {
        guard let index = self.items.firstIndex(of: activity) else {return 0}
        return index
    }
    
    func increaseCounter(activity: ActivityItem) -> Int {
        let index = self.getIndex(activity: activity)
        self.items[index].counter_completed += 1
        self.items[index].completedList.append(Date())
        if let encoded = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encoded, forKey: "Items")
        }
        return self.items[index].counter_completed
    }
    
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        return formatter.string(from: date)
    }
    
}
