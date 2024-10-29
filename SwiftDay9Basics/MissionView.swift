//
//  MissionView.swift
//  SwiftDay9Basics
//
//  Created by Bibek Bhujel on 19/10/2024.
//

import SwiftUI

struct CrewMember: Hashable {
    let role: String
    let astronaut: Astronaut
}

struct MissionView: View {
    let mission: Mission
    let crew: [CrewMember]
    
    init(mission: Mission, astronauts: [String: Astronaut]) {
        self.mission = mission
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts[member.name] {
                return CrewMember(role: member.role, astronaut: astronaut)
            } else {
                fatalError("Missing \(member.name)")
                // data is missing in the json file ( which is a huge blunder in the first place )
            }
        }
    }
    
    
    
    var body: some View {
        ScrollView {
                    VStack {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .containerRelativeFrame(.horizontal) { width, axis in
                                width * 0.6
                            }
                            .padding(.top)
                        Text(mission.formattedLaunchDate)
                            .padding(3)
                        CustomLineView()
                        
                        VStack(alignment: .leading) {
                            Text("Mission Highlights")
                                .font(.title.bold())
                                .padding(.bottom, 5)

                            Text(mission.description)
                            CustomLineView()
                            Text("Crew")
                                .font(.title.bold())
                                .padding(.bottom, 5)
                        }
                        .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            CrewMemberListView(crew: crew)
                        }
                    }
                    .padding(.bottom)
                }
                .navigationTitle(mission.displayName)
                .navigationBarTitleDisplayMode(.inline)
                .background(.darkBackground)
    }
}

struct CustomLineView: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundStyle(.lightBackground)
            .padding(.vertical)
    }
}
struct CrewMemberListView: View {
    let crew: [CrewMember]
    
    var body: some View {
            HStack {
                ForEach(crew, id: \.role) { crewMember in
                    NavigationLink(value: crewMember,label: {
                        HStack {
                            Image(crewMember.astronaut.id)
                                .resizable()
                                .frame(width: 104, height: 72)
                                .clipShape(.capsule)
                                .overlay(
                                    Capsule()
                                        .strokeBorder(.white, lineWidth: 1)
                                )
                            VStack(alignment: .leading) {
                                Text(crewMember.astronaut.name)
                                    .foregroundStyle(.white)
                                    .font(.headline)
                                Text(crewMember.role)
                                    .foregroundStyle(.white.opacity(0.5))
                            }
                        }.padding(.horizontal)
                    })
                    
                }
            } .navigationDestination(for: CrewMember.self) { crewMember in
                AstronautView(astronaut: crewMember.astronaut)
            }
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    MissionView(mission: missions[0], astronauts: astronauts)
        .preferredColorScheme(.dark)
}
