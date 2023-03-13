//
//  LoverControllerTests.swift
//  ColorLoversListTests
//
//  Created by Grzesiek on 12/01/2018.
//  Copyright © 2018 Grzesiek. All rights reserved.
//

import XCTest
@testable import ColorLovers

class LoverControllerTests: XCTestCase {
    
    func testPositiveResponse() async {
        
        var data1 = Data()
        var data2 = Data()
        let lovers1 = [Lover(userName: "Etienne", numColors: 100, numPalettes: 23, numPatterns: 198, rating: 1000),
                      Lover(userName: "Jean", numColors: 12, numPalettes: 78, numPatterns: 300, rating: 900)]
        
        let lovers2 = [Lover(userName: "Paul", numColors: 23, numPalettes: 244, numPatterns: 786, rating: 800),
                       Lover(userName: "Pierre", numColors: 456, numPalettes: 222, numPatterns: 111, rating: 700)]
        
        do {
            data1 = try JSONEncoder().encode(lovers1)
            data2 = try JSONEncoder().encode(lovers2)
        }
        catch {
            XCTFail()
        }
        
        let response = HTTPURLResponse(url: URL(string: "test")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let loverController = LoverController(connection: NetworkingMock(data: data1, error: nil, response: response))
        
        do {
            let lovers = try await loverController.lovers(offset: 0)
            XCTAssertEqual(lovers, lovers1)
        } catch {
            XCTFail()
        }
        loverController.connection = NetworkingMock(data: data2, error: nil, response: response)
        do {
            let lovers = try await loverController.lovers(offset: 0)
            XCTAssertEqual(lovers.count, lovers1.count + lovers2.count)
            XCTAssertEqual(lovers, lovers1 + lovers2)
        } catch {
            XCTFail()
        }
    }
    
    func testNegativeResponse() async {
        
        let response = HTTPURLResponse(url: URL(string: "test")!, statusCode: 400, httpVersion: nil, headerFields: nil)
        let loverController = LoverController(connection: NetworkingMock(data: nil, error: nil, response: response))
        do {
            _ = try await loverController.lovers(offset: 0)
            XCTFail()
        } catch {
            XCTAssertEqual(error as! ResponseError, ResponseError.invalidResponseError)
        }
    }
    
    func testNegativeError() async {
        
        let response = HTTPURLResponse(url: URL(string: "test")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        let loverController = LoverController(connection: NetworkingMock(data: nil, error: ResponseError.connectionError, response: response))
        do {
            _ = try await loverController.lovers(offset: 0)
            XCTFail()
        } catch {
            XCTAssertEqual(error as! ResponseError, ResponseError.connectionError)
        }
    }

    func testSortByRating() {
        
        let lover1 = Lover(userName: "Etienne", numColors: 100, numPalettes: 23, numPatterns: 198, rating: 1000)
        let lover2 = Lover(userName: "Jean", numColors: 12, numPalettes: 78, numPatterns: 300, rating: 900)
        let lover3 = Lover(userName: "Zoltan", numColors: 12, numPalettes: 78, numPatterns: 300, rating: 800)
        
        let loverController = LoverController()
        var sortedLovers: [Lover] = []
        sortedLovers = loverController.sortLoversByRatingAndName(lovers: [lover1, lover2, lover3])
        XCTAssertEqual(sortedLovers, [lover1, lover2, lover3])
        sortedLovers = loverController.sortLoversByRatingAndName(lovers: [lover3, lover1, lover2])
        XCTAssertEqual(sortedLovers, [lover1, lover2, lover3])
    }
    
    func testSortNameWithEqualRating() {
        
        let lover1 = Lover(userName: "Etienne", numColors: 100, numPalettes: 23, numPatterns: 198, rating: 1000)
        let lover2 = Lover(userName: "Jean", numColors: 12, numPalettes: 78, numPatterns: 300, rating: 1000)
        let lover3 = Lover(userName: "Zoltan", numColors: 32, numPalettes: 99, numPatterns: 500, rating: 1000)
        
        let loverController = LoverController()
        var sortedLovers: [Lover] = []
        sortedLovers = loverController.sortLoversByRatingAndName(lovers: [lover1, lover2, lover3])
        XCTAssertEqual(sortedLovers, [lover1, lover2, lover3])
        sortedLovers = loverController.sortLoversByRatingAndName(lovers: [lover3, lover1, lover2])
        XCTAssertEqual(sortedLovers, [lover1, lover2, lover3])
    }
    
    func testSortRatingWithEqualRatingName() {
        
        let lover1 = Lover(userName: "Etienne", numColors: 100, numPalettes: 23, numPatterns: 198, rating: 1000)
        let lover2 = Lover(userName: "Etienne", numColors: 12, numPalettes: 78, numPatterns: 300, rating: 1000)
        let lover3 = Lover(userName: "Etienne", numColors: 32, numPalettes: 99, numPatterns: 500, rating: 1000)
        
        let loverController = LoverController()
        var sortedLovers: [Lover] = []
        sortedLovers = loverController.sortLoversByRatingAndName(lovers: [lover1, lover2, lover3])
        XCTAssertEqual(sortedLovers, [lover1, lover2, lover3])
        sortedLovers = loverController.sortLoversByRatingAndName(lovers: [lover3, lover1, lover2])
        XCTAssertEqual(sortedLovers, [lover3, lover1, lover2])
    }
}
