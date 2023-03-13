//
//  Types.swift
//  ColorLoversList
//
//  Created by Grzesiek on 08/01/2018.
//  Copyright © 2018 Grzesiek. All rights reserved.
//

import Foundation

typealias RequestParameters = [String: Any]?

typealias BodyParameters = [String: Any]?

typealias Headers = [String: String]?

enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
}

enum ResponseError: Error {
    case connectionError
    case invalidResponseError
    case decodeError
    case unknownError
    
    var errorDescription: String {
        switch self {
        case .connectionError: return "Connection error"
        case .invalidResponseError: return "Invalid response Error"
        case .decodeError: return "Data decode error"
        case .unknownError: return "Unknown error"
        }
    }
}
