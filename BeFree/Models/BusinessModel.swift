//
//  BusinessModel.swift
//  BeFree
//
//  Created by Tim Meiwirth on 22.11.25.
//

import Foundation

struct BusinessModel: Identifiable, Codable {
    let id: UUID
    let name: String
    let shortName: String // e.g., "SMMA"
    let description: String
    let icon: String // SF Symbol name
    let benefits: [String]
    
    init(
        id: UUID = UUID(),
        name: String,
        shortName: String,
        description: String,
        icon: String,
        benefits: [String]
    ) {
        self.id = id
        self.name = name
        self.shortName = shortName
        self.description = description
        self.icon = icon
        self.benefits = benefits
    }
}

