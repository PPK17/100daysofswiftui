//
//  CacheUser+CoreDataProperties.swift
//  Consolidation V
//
//  Created by Pedro Pablo on 11/08/23.
//
//

import Foundation
import CoreData


extension CacheUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CacheUser> {
        return NSFetchRequest<CacheUser>(entityName: "CacheUser")
    }

    @NSManaged public var id: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var address: String?
    @NSManaged public var about: String?
    @NSManaged public var registered: Date?
    @NSManaged public var tags: String?
    @NSManaged public var friend: NSSet?
    
    var friendArray: [CacheFriend] {
        let set = friend as? Set<CacheFriend> ?? []
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
    
    var wrappedName: String {
        return name ?? "Unknown"
    }
    
    var wrappedCompany: String {
        return company ?? "Unknown"
    }
    
    var wrappedAddress: String {
        return address ?? "Unknown"
    }
    
    var wrappedAbout: String {
        return about ?? "Unknown"
    }
    
    var wrappedTags: String {
        return tags ?? "-"
    }
    
    var totalFriends: Int {
        friendArray.count
    }
    
    var loginText: String {
        return isActive ? "Logged In" : "Logged out"
    }
    
    var loginImage: String {
        return isActive ? "person.crop.circle.fill.badge.checkmark" : "person.crop.circle.fill.badge.xmark"
    }
    
    var stringRegistered: String {
        if let value = registered {
            return value.formatted(date: .abbreviated, time: .shortened)
        }
        return "-"
    }
    
    var listTags: [String] {
        if let value = tags {
            return value.components(separatedBy: ",")
        }
        return []
    }
    
    var stringFriends: String {
        var listFriends = [String]()
        for friend in friendArray {
            var _ = print(friend.wrappedName)
            listFriends.append(friend.wrappedName)
        }
        return listFriends.joined(separator: ", ")
    }

}

// MARK: Generated accessors for friend
extension CacheUser {

    @objc(addFriendObject:)
    @NSManaged public func addToFriend(_ value: CacheFriend)

    @objc(removeFriendObject:)
    @NSManaged public func removeFromFriend(_ value: CacheFriend)

    @objc(addFriend:)
    @NSManaged public func addToFriend(_ values: NSSet)

    @objc(removeFriend:)
    @NSManaged public func removeFromFriend(_ values: NSSet)

}

extension CacheUser : Identifiable {

}
