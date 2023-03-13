//
//  LoversInterpreterTests.swift
//  ColorLoversListTests
//
//  Created by Grzesiek on 12/01/2018.
//  Copyright © 2018 Grzesiek. All rights reserved.
//

import XCTest
@testable import ColorLovers

class LoversInterpreterTests: XCTestCase {
    
    func testLoversInterpreterValidData() {
        
        var data: Data?
        let response = HTTPURLResponse(url: URL(string: "test")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let successStatusCode = 200
        
        let lovers = [Lover(userName: "Etienne", numColors: 100, numPalettes: 23, numPatterns: 198, rating: 1029),
                      Lover(userName: "Jean", numColors: 12, numPalettes: 78, numPatterns: 300, rating: 100)]

        do {
            data = try JSONEncoder().encode(lovers)
        }
        catch {
            XCTFail()
        }
        
        let loversInterpreter = LoversInterpreter()
        let resp = loversInterpreter.interpret(data: data, response: response, error: nil, successStatusCode: successStatusCode)
        switch resp {
        case .success(let data):
            XCTAssertEqual(data, lovers)
        case .failure(_):
            XCTFail()
        }
    }
    
    func testLoversInterpreterInvalidResponse() {
        
        let response = HTTPURLResponse(url: URL(string: "test")!, statusCode: 400, httpVersion: nil, headerFields: nil)
        let successStatusCode = 400
        let loversInterpreter = LoversInterpreter()
        let resp = loversInterpreter.interpret(data: nil, response: response, error: nil, successStatusCode: successStatusCode)
        switch resp {
        case .success(_):
            XCTFail()
        case .failure(let responseError):
            XCTAssertEqual(responseError, ResponseError.invalidResponseError)
        }
    }

    func testLoversInterpreterError() {

        let response = HTTPURLResponse()
        let error = NSError(domain: "test", code: 100, userInfo: nil)
        let successStatusCode = 400
        
        let loversInterpreter = LoversInterpreter()
        let resp = loversInterpreter.interpret(data: nil, response: response, error: error, successStatusCode: successStatusCode)
        switch resp {
        case .success(_):
            XCTFail()
        case .failure(let responseError):
            XCTAssertEqual(responseError, ResponseError.connectionError)
        }
    }
}
