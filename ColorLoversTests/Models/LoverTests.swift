//
//  LoverTests.swift
//  ColorLoversListTests
//
//  Created by Grzesiek on 13/01/2018.
//  Copyright © 2018 Grzesiek. All rights reserved.
//

import XCTest
@testable import ColorLovers

class LoverTest: XCTestCase {
    
    func testEquatable() {
        let lover1 = Lover(userName: "Tony", numColors: 23, numPalettes: 1, numPatterns: 100, rating: 999)
        let lover2 = Lover(userName: "Tony", numColors: 23, numPalettes: 1, numPatterns: 100, rating: 999)
        let lover1_1 = Lover(userName: "Tony1", numColors: 23, numPalettes: 1, numPatterns: 100, rating: 999)
        let lover1_2 = Lover(userName: "Tony", numColors: 233, numPalettes: 1, numPatterns: 100, rating: 999)
        let lover1_3 = Lover(userName: "Tony", numColors: 23, numPalettes: 12, numPatterns: 100, rating: 999)
        let lover1_4 = Lover(userName: "Tony", numColors: 23, numPalettes: 1, numPatterns: 1000, rating: 999)
        let lover1_5 = Lover(userName: "Tony", numColors: 23, numPalettes: 1, numPatterns: 100, rating: 9999)

        XCTAssertEqual(lover1, lover2)
        XCTAssertNotEqual(lover1, lover1_1)
        XCTAssertNotEqual(lover1, lover1_2)
        XCTAssertNotEqual(lover1, lover1_3)
        XCTAssertNotEqual(lover1, lover1_4)
        XCTAssertNotEqual(lover1, lover1_5)
    }
}
