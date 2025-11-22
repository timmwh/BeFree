//
//  Resource.swift
//  BeFree
//
//  Created by Tim Meiwirth on 22.11.25.
//

import Foundation

enum ResourceType: String, Codable {
    case video
    case article
    case template
}

struct Resource: Identifiable, Codable {
    let id: UUID
    let title: String
    let type: ResourceType
    let url: String
    let duration: String? // e.g., "12 min" for videos, "5 min read" for articles
    
    init(id: UUID = UUID(), title: String, type: ResourceType, url: String, duration: String? = nil) {
        self.id = id
        self.title = title
        self.type = type
        self.url = url
        self.duration = duration
    }
}

