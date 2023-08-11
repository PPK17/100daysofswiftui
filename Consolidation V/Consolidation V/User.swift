//
//  User.swift
//  Consolidation V
//
//  Created by Pedro Pablo on 9/08/23.
//

import Foundation
import SwiftUI

struct User: Codable, Identifiable {
    var id: String
    var isActive: Bool
    var name: String
    var age: Int8
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [Friend]
    
    struct Friend: Codable, Identifiable {
        var id: String
        var name: String
    }
    
    var totalFriends: Int {
        friends.count
    }
    
    var loginText: String {
        return self.isActive ? "Logged In" : "Logged out"
    }
    
    var loginImage: String {
        return self.isActive ? "person.crop.circle.fill.badge.checkmark" : "person.crop.circle.fill.badge.xmark"
    }
    
    var stringRegistered: String {
        self.registered.formatted(date: .abbreviated, time: .shortened)
    }
    
    var stringTags: String {
        self.tags.joined(separator: ", ")
    }
    
    var stringFriends: String {
        var listFriends = [String]()
        for friend in self.friends {
            listFriends.append(friend.name)
        }
        return listFriends.joined(separator: ", ")
    }
    
    
}
