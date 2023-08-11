//
//  ContentView.swift
//  Consolidation V
//
//  Created by Pedro Pablo on 9/08/23.
//

import SwiftUI

struct ContentView: View {
    @State private var results = [User]()
    
    var body: some View {
        NavigationView {
            List(results, id: \.id) { item in
                NavigationLink {
                    UserDetailTemplate(user: item)
                } label: {
                    LazyVStack(alignment: .leading) {
                        ListUsersTemplate(user: item)
                    }
                }
                .navigationTitle("List of users")
            }
            .task {
                await loadData()
            }
        }
    }
    
    func loadData() async {
        if results.count == 0 {
            guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
                var _ = print("Invalid URL")
                return
            }
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let decodedResponse = try decoder.decode([User].self, from: data)
                results = decodedResponse.sorted {
                    $0.name < $1.name
                    //                $0.loginText < $1.loginText
                }
            } catch {
                var _ = print("Checkout failed: \(error)")
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
