//
//  Order.swift
//  Project 10
//
//  Created by Pedro Pablo on 23/07/23.
//

import SwiftUI

class NewOrder: ObservableObject {
    
    struct Order: Codable {
        static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
        
        var type = 0
        var quantity = 3
        var extraFrosting = false
        var addSprinkles = false
        var name = ""
        var streetAddress = ""
        var city = ""
        var zip = ""
        
        var specialRequestEnabled = false {
            didSet {
                if !specialRequestEnabled {
                    extraFrosting = false
                    addSprinkles = false
                }
            }
        }
        
        var hasValidAddress: Bool {
            var isValid = true
            if String(name).trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                isValid = false
            } else if String(streetAddress).trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                isValid = false
            } else if String(city).trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                isValid = false
            } else if String(zip).trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                isValid = false
            }
            return isValid
        }
        
        var cost: Double {
            var cost = Double(quantity) * 2
            cost += (Double(type) / 2)
            if extraFrosting {
                cost += Double(quantity)
            }
            if addSprinkles {
                cost += Double(quantity) / 2
            }
            return cost
        }
        
    }
    
    @Published var order = Order()
}
