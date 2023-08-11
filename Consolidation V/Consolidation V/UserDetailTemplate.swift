//
//  UserDetailTemplate.swift
//  Consolidation V
//
//  Created by Pedro Pablo on 10/08/23.
//

import SwiftUI

struct UserDetailTemplate: View {
    var user: User
    let columns = [
        GridItem(.fixed(100)),
        GridItem(.flexible()),
    ]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                Image(systemName: user.loginImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .foregroundColor(user.isActive ? Color.green : Color.red)
                Text(user.name)
                    .font(.system(size: 35, weight: .bold))
                LazyVGrid(columns: columns, alignment:.leading, spacing: 10) {
                    Text("Registered:")
                    Text(user.stringRegistered)
                    Text("Company:")
                    Text(user.company)
                    Text("Address:")
                    Text(user.address)
                    Text("Age:")
                    Text("\(user.age)")
                    Text("Tags:")
                    Text(user.stringTags)
                    
                }
                LazyVGrid(columns: columns, alignment:.leading, spacing: 10) {
                    Text("Friends:")
                    Text(user.stringFriends)
                    Text("About:")
                    Text(user.about)
                }
                Spacer()
            }
            .padding()
        }
        
    }

}

struct UserDetailTemplate_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailTemplate(user: User(id: "1", isActive: true, name: "PPK", age: 21,
                                      company: "Company", email: "ppk17@gmail.com", address: "address",
                                      about: "about", registered: Date(), tags: ["tag1", "tag2"],
                                      friends: [User.Friend(id: "1f", name: "Friend 1")]))
    }
}
