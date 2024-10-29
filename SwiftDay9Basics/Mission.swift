//
//  Mission.swift
//  SwiftDay9Basics
//
//  Created by Bibek Bhujel on 19/10/2024.
//

import Foundation

struct Mission: Identifiable, Codable, Hashable{
    // nesting structure as CrewRole is soley a part of Mission structure
    // We could do Mission.CrewRole 
   
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    struct CrewRole: Codable, Hashable {
        let name: String
        let role: String
    }
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate:String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
}


