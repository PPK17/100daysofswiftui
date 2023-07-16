//
//  ListTemplateView.swift
//  project 8
//
//  Created by Pedro Pablo on 16/07/23.
//

import SwiftUI

struct ListTemplateView: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]
    
    init(missions: [Mission], astronauts: [String: Astronaut]) {
        self.missions = missions
        self.astronauts = astronauts
    }
    
    var body: some View {
        List {
            ForEach(missions) { mission in
                Section(mission.displayName) {
                    NavigationLink {
                        MissionView(mission: mission, astronauts: astronauts)
                    } label: {
                        HStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                            VStack(alignment: .leading) {
                                Text(mission.formattedLaunchDate)
                            }
                            .foregroundColor(.white.opacity(0.5))
                        }
                    }
                }
                .font(.headline.bold())
                .foregroundColor(.white)
                
            }
        }
    }
}

struct ListTemplateView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        ListTemplateView(missions: missions, astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
