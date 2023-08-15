//
//  ContentView.swift
//  Consolidation V
//
//  Created by Pedro Pablo on 9/08/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)]) var users: FetchedResults<CacheUser>
    
    var body: some View {
        NavigationView {
            List(users, id: \.self) { item in
                NavigationLink {
                    UserDetailTemplate(user: item)
                } label: {
                    LazyVStack(alignment: .leading) {
                        ListUsersTemplate(user: item)
                    }
                }
                .navigationTitle("List of users")
            }.task {
                if users.isEmpty {
                    if let retrievedUsers = await getUsers() {
                        await MainActor.run {
                            for user in retrievedUsers {
                                let cacheUser = CacheUser(context: moc)
                                cacheUser.id = user.id
                                cacheUser.isActive = user.isActive
                                cacheUser.name = user.name
                                cacheUser.age = user.age
                                cacheUser.company = user.company
                                cacheUser.email = user.email
                                cacheUser.address = user.address
                                cacheUser.about = user.about
                                cacheUser.registered = user.registered
                                cacheUser.tags = user.tags.joined(separator: ",")
                                for friend in user.friends {
                                    let mocFriend = CacheFriend(context: moc)
                                    mocFriend.id = friend.id
                                    mocFriend.name = friend.name
                                    cacheUser.addToFriend(mocFriend)
                                }
                            }
                        }
                        try? moc.save()
                    }
                }
            }
        }
    }
    
    func getUsers() async -> [User]? {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            var _ = print("Invalid URL")
            return nil
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let decodedResponse = try decoder.decode([User].self, from: data)
            let results = decodedResponse.sorted {
                $0.name < $1.name
            }
            return results
        } catch {
            return nil
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
