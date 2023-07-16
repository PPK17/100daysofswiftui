//
//  DefaultTemplateView.swift
//  project 8
//
//  Created by Pedro Pablo on 15/07/23.
//

import SwiftUI

struct GridTemplateView: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    init(missions: [Mission], astronauts: [String: Astronaut]) {
        self.missions = missions
        self.astronauts = astronauts
    }
    
    var body: some View {
        LazyVGrid(columns: columns) {
            ForEach(missions) { mission in
                NavigationLink {
                    MissionView(mission: mission, astronauts: astronauts)
                } label: {
                    VStack {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                        
                        VStack {
                            Text(mission.displayName)
                                .font(.headline)
                                .foregroundColor(.white)
                            Text(mission.formattedLaunchDate)
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.5))
                        }
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                        .background(.lightBackground)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(.lightBackground)
                    )
                }
            }
        }
        .padding([.horizontal, .vertical])
    }
    
}

struct GridTemplateView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        GridTemplateView(missions: missions, astronauts: astronauts)
            .preferredColorScheme(.dark)
    }
}
