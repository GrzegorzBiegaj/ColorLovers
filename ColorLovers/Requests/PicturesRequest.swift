//
//  PicturesRequest.swift
//  ColorLoversList
//
//  Created by Grzesiek on 09/01/2018.
//  Copyright © 2018 Grzesiek. All rights reserved.
//

import Foundation

struct PicturesRequest: RequestProtocol {

    let offset: Int
    let number: Int
    let userName: String
    let pictureType: PictureType
    
    // MARK: Request protocol

    var endpoint: String { return "http://www.colourlovers.com/api/\(pictureType.description)" }

    var requestParameters: RequestParameters {

        return [
            "format": "json",
            "lover": userName,
            "resultOffset": offset,
            "numResults": number,
            "orderCol": "dateCreated"]
    }

    let interpreter: PicturesInterpreter = PicturesInterpreter()
}
