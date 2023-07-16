//
//  ContentView.swift
//  project 8
//
//  Created by Pedro Pablo on 15/07/23.
//

import SwiftUI

enum TemplateViews: String, CaseIterable, Identifiable {
    case gridView = "GRID VIEW"
    case listView = "LIST VIEW"
    var id: Self {self}
}

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    @State private var currentTemplate: TemplateViews = .gridView
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationView {
            switch currentTemplate {
            case .gridView:
                ScrollView {
                    GridTemplateView(missions: missions, astronauts: astronauts)
                }
                .modifier(Footer())
                .toolbar {
                    Picker("Choose View", selection: $currentTemplate) {
                        iterateEnum(items: TemplateViews.allCases)
                    }
                }
            case .listView:
                ListTemplateView(missions: missions, astronauts: astronauts)
                    .modifier(Footer())
                    .toolbar {
                        Picker("Choose View", selection: $currentTemplate) {
                            iterateEnum(items: TemplateViews.allCases)
                        }
                    }
            }
        }
    }
    
    struct Footer: ViewModifier {
        func body(content: Content) -> some View {
            content
                .navigationTitle("Moonshot")
                .background(.darkBackground)
                .preferredColorScheme(.dark)
        }
    }
    
    func iterateEnum(items: [TemplateViews]) -> some View {
        ForEach(items, id: \.id) { item in
            Text(item.rawValue).foregroundColor(.lightBackground)
        }
    }
    
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
