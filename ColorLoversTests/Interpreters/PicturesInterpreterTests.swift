//
//  PicturesInterpreterTests.swift
//  ColorLoversListTests
//
//  Created by Grzesiek on 13/01/2018.
//  Copyright © 2018 Grzesiek. All rights reserved.
//

import XCTest
@testable import ColorLovers

class PicturesInterpreterTests: XCTestCase {
    
    func testPicturesInterpreterValidData() {
        
        var data: Data?
        let response = HTTPURLResponse(url: URL(string: "test")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let successStatusCode = 200
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: "2017-01-13 12:22:33")!
        
        let pictures = [Picture(title: "test1", dateCreated: date, imageUrl: "imageUrl", numVotes: 123),
                        Picture(title: "test2", dateCreated: date, imageUrl: "imageUrl2", numVotes: 1000)]
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .custom { (date, ec) in
            var container = ec.singleValueContainer()
            let dateFormatter = DateFormatter()
            dateFormatter.locale = .current
            dateFormatter.timeZone = .current
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let stringData = dateFormatter.string(from: date)
            try container.encode(stringData)
        }
        do {
            data = try encoder.encode(pictures)
        }
        catch {
            XCTFail()
        }
        
        let picturesInterpreter = PicturesInterpreter()
        let resp = picturesInterpreter.interpret(data: data, response: response, error: nil, successStatusCode: successStatusCode)
        switch resp {
        case .success(let data):
            XCTAssertEqual(data, pictures)
        case .failure(_):
            XCTFail()
        }
    }

    func testPicturesInterpreterInvalidResponse() {
        
        let response = HTTPURLResponse(url: URL(string: "test")!, statusCode: 400, httpVersion: nil, headerFields: nil)
        let successStatusCode = 400
        let picturesInterpreter = PicturesInterpreter()
        let resp = picturesInterpreter.interpret(data: nil, response: response, error: nil, successStatusCode: successStatusCode)
        switch resp {
        case .success(_):
            XCTFail()
        case .failure(let responseError):
            XCTAssertEqual(responseError, ResponseError.invalidResponseError)
        }
    }
    
    func testPicturesInterpreterError() {
        
        let response = HTTPURLResponse()
        let error = NSError(domain: "test", code: 100, userInfo: nil)
        let successStatusCode = 400
        
        let picturesInterpreter = PicturesInterpreter()
        let resp = picturesInterpreter.interpret(data: nil, response: response, error: error, successStatusCode: successStatusCode)
        switch resp {
        case .success(_):
            XCTFail()
        case .failure(let responseError):
            XCTAssertEqual(responseError, ResponseError.connectionError)
        }
    }
    
}
