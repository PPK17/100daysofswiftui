//
//  UserDetailTemplate.swift
//  Consolidation V
//
//  Created by Pedro Pablo on 10/08/23.
//

import SwiftUI

struct UserDetailTemplate: View {
    var user: CacheUser
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
                Text(user.wrappedName)
                    .font(.system(size: 35, weight: .bold))
                LazyVGrid(columns: columns, alignment:.leading, spacing: 10) {
                    Text("Registered:")
                    Text(user.stringRegistered)
                    Text("Company:")
                    Text(user.wrappedCompany)
                    Text("Address:")
                    Text(user.wrappedAddress)
                    Text("Age:")
                    Text("\(user.age)")
                    Text("Tags:")
                    Text(user.wrappedTags)
                    
                }
                LazyVGrid(columns: columns, alignment:.leading, spacing: 10) {
                    Text("Friends:")
                    Text(user.stringFriends)
                    Text("About:")
                    Text(user.wrappedAbout)
                }
                Spacer()
            }
            .padding()
        }
        
    }

}
