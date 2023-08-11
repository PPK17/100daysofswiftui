//
//  ListUsersTemplate.swift
//  Consolidation V
//
//  Created by Pedro Pablo on 10/08/23.
//

import SwiftUI

struct ListUsersTemplate: View {
    var user: User
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(user.name)
                    .font(.headline)
                Text("Friends: \(user.totalFriends)")
            }
            Spacer()
            VStack {
                Image(systemName: user.loginImage)
                    .foregroundColor(user.isActive ? Color.green : Color.red)
                Text(user.loginText)
                    .foregroundColor(user.isActive ? Color.green : Color.red)
                    .font(.subheadline)
            }
            
        }
    }
}

struct ListUsersTemplate_Previews: PreviewProvider {
    static var previews: some View {
        ListUsersTemplate(user: User(id: "1", isActive: true, name: "PPK", age: 21,
                                     company: "Company", email: "ppk17@gmail.com", address: "address",
                                     about: "about", registered: Date(), tags: ["tag1", "tag2"],
                                     friends: [User.Friend(id: "1f", name: "Friend 1")]))
    }
}
