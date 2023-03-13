//
//  LoversRequestTests.swift
//  ColorLoversListTests
//
//  Created by Grzesiek on 12/01/2018.
//  Copyright © 2018 Grzesiek. All rights reserved.
//

import XCTest
@testable import ColorLovers

class LoversRequestTests: XCTestCase {
    
    func testLoversRequest() {
        
        let offset = 10
        let number = 100
        let loversRequest = LoversRequest(offset: 10, number: 100)
        
        XCTAssertEqual(loversRequest.successStatusCode, 200)
        XCTAssertEqual(loversRequest.httpMethod, .get)
        XCTAssertEqual(loversRequest.endpoint, "http://www.colourlovers.com/api/lovers/top")
        XCTAssertEqual(loversRequest.requestParameters?["format"] as? String, "json")
        XCTAssertEqual(loversRequest.requestParameters?["resultOffset"] as? Int, offset)
        XCTAssertEqual(loversRequest.requestParameters?["numResults"] as? Int, number)
        XCTAssertNil(loversRequest.bodyParameters)
        XCTAssertNil(loversRequest.headers)
    }
    
}
