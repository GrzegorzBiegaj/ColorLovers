//
//  PictureControllerTests.swift
//  ColorLoversListTests
//
//  Created by Grzesiek on 13/01/2018.
//  Copyright © 2018 Grzesiek. All rights reserved.
//

import XCTest
@testable import ColorLovers

class PictureControllerTests: XCTestCase {
    
    func testPositiveResponse() async {
        
        var data1 = Data()
        var data2 = Data()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: "2017-01-13 12:22:33")!
        
        let pictures1 = [Picture(title: "test1", dateCreated: date, imageUrl: "imageUrl", numVotes: 123),
                        Picture(title: "test2", dateCreated: date, imageUrl: "imageUrl2", numVotes: 1000)]
        let pictures2 = [Picture(title: "test1", dateCreated: date, imageUrl: "imageUrl", numVotes: 123),
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
            data1 = try encoder.encode(pictures1)
            data2 = try encoder.encode(pictures2)
        }
        catch {
            XCTFail()
        }
        
        let response = HTTPURLResponse(url: URL(string: "test")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let pictureController = PictureController(connection: NetworkingMock(data: data1, error: nil, response: response))
        do {
            let pictures = try await pictureController.pictures(offset: 0, userName: "test", pictureType: .pattern)
            XCTAssertEqual(pictures, pictures1)
        } catch {
            XCTFail()
        }

        pictureController.connection = NetworkingMock(data: data2, error: nil, response: response)
        do {
            let pictures = try await pictureController.pictures(offset: 0, userName: "test", pictureType: .pattern)
            XCTAssertEqual(pictures.count, pictures1.count + pictures2.count)
            XCTAssertEqual(pictures, pictures1 + pictures2)
        } catch {
            XCTFail()
        }
    }

    func testNegativeResponse() async {
        
        let response = HTTPURLResponse(url: URL(string: "test")!, statusCode: 400, httpVersion: nil, headerFields: nil)
        let pictureController = PictureController(connection: NetworkingMock(data: nil, error: nil, response: response))
        do {
            _ = try await pictureController.pictures(offset: 0, userName: "test", pictureType: .pattern)
            XCTFail()
        } catch {
            XCTAssertEqual(error as! ResponseError, ResponseError.invalidResponseError)
        }
    }
    
    func testNegativeError() async {
        
        let response = HTTPURLResponse(url: URL(string: "test")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let pictureController = PictureController(connection: NetworkingMock(data: nil, error: nil, response: response))
        do {
            _ = try await pictureController.pictures(offset: 0, userName: "test", pictureType: .pattern)
            XCTFail()
        } catch {
            XCTAssertEqual(error as! ResponseError, ResponseError.invalidResponseError)
        }
    }
}
