//
//  Picture.swift
//  ColorLoversList
//
//  Created by Grzesiek on 09/01/2018.
//  Copyright © 2018 Grzesiek. All rights reserved.
//

import Foundation

struct Picture: Codable, Equatable {
    var title: String
    var dateCreated: Date
    var imageUrl: String
    var numVotes: Int
    
    static func ==(lhs: Picture, rhs: Picture) -> Bool {
        return lhs.title == rhs.title &&
            lhs.dateCreated == rhs.dateCreated &&
            lhs.imageUrl == rhs.imageUrl &&
            lhs.numVotes == rhs.numVotes
    }
}

enum PictureType: Int {
    
    case pattern, palette, color
    
    var description: String {
        switch self {
        case .pattern: return "patterns"
        case .palette: return "palettes"
        case .color: return "colors"
        }
    }
}
