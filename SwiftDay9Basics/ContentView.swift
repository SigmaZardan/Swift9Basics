//
//  ContentView.swift
//  SwiftDay9Basics
//
//  Created by Bibek Bhujel on 19/10/2024.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String:Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
  
    @State private var showListView: Bool = false
    
    var showsIndicators: Bool {
        !showListView
    }
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Toggle(isOn: $showListView) {
                        Text("List Layout")
                            .font(.headline)
                    }
                }.padding(.horizontal,32)
                ScrollView(showsIndicators:showsIndicators){
                    if showListView {
                        MissionsListView(missions: missions, astronauts: astronauts)
                    }
                    else {
                        MissionsGridView(missions: missions, astronauts: astronauts)
                    }
                }
                .padding([.horizontal, .bottom])
            }
            .navigationTitle("Moonshot")
            .navigationBarTitleDisplayMode(.inline)
            .background(.darkBackground)
            .preferredColorScheme(.dark)
        }
    }
}


struct MissionsListView: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]
    
    
    var body: some View {
        LazyVStack {
                ForEach(missions) { mission in
                    NavigationLink(value: mission, label: {
                        HStack{
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width:50, height:50)
                                    .padding()
                            Spacer()
                            VStack {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundStyle(.white)
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundStyle(.white.opacity(0.5))
                                
                            }
                            Spacer()
                            Image(systemName:"arrow.forward")
                                .foregroundStyle(.white)
                                .padding(.horizontal)
                            
                        }.frame(maxWidth: .infinity)
                            .clipShape(.rect(cornerRadius:10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.lightBackground)
                            ).padding(5)
                    })
                   
                }
        }.navigationDestination(for: Mission.self) {
            mission
            in
            MissionView(mission:mission , astronauts: astronauts)
        }
    }
}


struct  MissionsGridView: View {
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    let missions: [Mission]
    let astronauts: [String: Astronaut]
    var body: some View {
        LazyVGrid(columns:columns){
            ForEach(missions) { mission in
                NavigationLink(value: mission, label: {
                    VStack {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width:100, height:100)
                        VStack {
                            Text(mission.displayName)
                                .font(.headline)
                                .foregroundStyle(.white)
                            Text(mission.formattedLaunchDate)
                                .font(.caption)
                                .foregroundStyle(.white.opacity(0.5))
                        }.padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(.lightBackground)
                        
                    }
                    .clipShape(.rect(cornerRadius:10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.lightBackground)
                    )
                    .padding()
                    
                })
            }
        }.navigationDestination(for: Mission.self) {
            mission in
            MissionView(mission: mission, astronauts: astronauts)
        }
    }
}

#Preview {
    ContentView()
}
