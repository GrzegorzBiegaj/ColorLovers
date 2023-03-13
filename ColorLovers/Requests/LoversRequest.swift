//
//  LoversRequest.swift
//  ColorLoversList
//
//  Created by Grzesiek on 08/01/2018.
//  Copyright © 2018 Grzesiek. All rights reserved.
//

import Foundation

struct LoversRequest: RequestProtocol {
    
    let offset: Int
    let number: Int
    
    // MARK: Request protocol
    
    var endpoint: String { return "http://www.colourlovers.com/api/lovers/top" }
    
    var requestParameters: RequestParameters {
        
        return [
            "format": "json",
            "resultOffset": offset,
            "numResults": number]
    }
    
    let interpreter: LoversInterpreter = LoversInterpreter()
}
