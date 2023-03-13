//
//  PicturesRequestTests.swift
//  ColorLoversListTests
//
//  Created by Grzesiek on 12/01/2018.
//  Copyright © 2018 Grzesiek. All rights reserved.
//

import XCTest
@testable import ColorLovers

class PicturesRequestTests: XCTestCase {
    
    func testPicturesRequest() {
        
        let offset = 10
        let number = 100
        let userName = "TestUser"
        let pictureType: PictureType = .pattern
        
        let picturesRequest = PicturesRequest(offset: offset, number: number, userName: userName, pictureType: pictureType)
        
        XCTAssertEqual(picturesRequest.successStatusCode, 200)
        XCTAssertEqual(picturesRequest.httpMethod, .get)
        XCTAssertEqual(picturesRequest.endpoint, "http://www.colourlovers.com/api/\(pictureType.description)")
        XCTAssertEqual(picturesRequest.requestParameters?["format"] as? String, "json")
        XCTAssertEqual(picturesRequest.requestParameters?["lover"] as? String, userName)
        XCTAssertEqual(picturesRequest.requestParameters?["resultOffset"] as? Int, offset)
        XCTAssertEqual(picturesRequest.requestParameters?["numResults"] as? Int, number)
        XCTAssertEqual(picturesRequest.requestParameters?["orderCol"] as? String, "dateCreated")
        XCTAssertNil(picturesRequest.bodyParameters)
        XCTAssertNil(picturesRequest.headers)
    }
}
