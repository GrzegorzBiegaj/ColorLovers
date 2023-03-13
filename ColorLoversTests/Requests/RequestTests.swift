//
//  RequestTests.swift
//  ColorLoversListTests
//
//  Created by Grzesiek on 13/01/2018.
//  Copyright © 2018 Grzesiek. All rights reserved.
//

import XCTest
@testable import ColorLovers

class RequestTests: XCTestCase {
    
    func testRequest() {
        
        struct TestRequest: RequestProtocol {
            var endpoint: String { return "testEndpoint" }
            let interpreter: TestInterpreter = TestInterpreter()
        }
        let testRequest = TestRequest()
        
        XCTAssertEqual(testRequest.successStatusCode, 200)
        XCTAssertEqual(testRequest.httpMethod, .get)
        XCTAssertEqual(testRequest.endpoint, "testEndpoint")
        XCTAssertNil(testRequest.requestParameters)
        XCTAssertNil(testRequest.bodyParameters)
        XCTAssertNil(testRequest.headers)
    }
    
}

class TestInterpreter: NetworkResponseInterpreter {
    
    func interpret(data: Data?, response: HTTPURLResponse?, error: Error?, successStatusCode: Int) -> Result<[Lover], ResponseError> {
        return Result.success([Lover(userName: "", numColors: 0, numPalettes: 0, numPatterns: 0, rating: 0)])
    }
}
