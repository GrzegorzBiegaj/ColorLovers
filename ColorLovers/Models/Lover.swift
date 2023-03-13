//
//  Lover.swift
//  ColorLoversList
//
//  Created by Grzesiek on 09/01/2018.
//  Copyright © 2018 Grzesiek. All rights reserved.
//

import Foundation

struct Lover: Codable, Equatable, Hashable {

    var userName: String
    var numColors: Int
    var numPalettes: Int
    var numPatterns: Int
    var rating: Int
    
    static func ==(lhs: Lover, rhs: Lover) -> Bool {
        return lhs.userName == rhs.userName &&
            lhs.numColors == rhs.numColors &&
            lhs.numPalettes == rhs.numPalettes &&
            lhs.numPatterns == rhs.numPatterns &&
            lhs.rating == rhs.rating
    }
}
