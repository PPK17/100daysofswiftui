//
//  ListUsersTemplate.swift
//  Consolidation V
//
//  Created by Pedro Pablo on 10/08/23.
//

import SwiftUI

struct ListUsersTemplate: View {
    var user: CacheUser
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(user.wrappedName)
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
