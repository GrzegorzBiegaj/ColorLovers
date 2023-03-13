//
//  PictureTests.swift
//  ColorLoversListTests
//
//  Created by Grzesiek on 13/01/2018.
//  Copyright © 2018 Grzesiek. All rights reserved.
//

import XCTest
@testable import ColorLovers

class PictureTests: XCTestCase {
    
    func testEquatable() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date1 = dateFormatter.date(from: "2017-01-13 12:22:33")!
        let date2 = dateFormatter.date(from: "2017-01-13 12:22:34")!
        
        let picture1 = Picture(title: "Pic1", dateCreated: date1, imageUrl: "url1", numVotes: 100)
        let picture2 = Picture(title: "Pic1", dateCreated: date1, imageUrl: "url1", numVotes: 100)
        let picture1_1 = Picture(title: "Pic2", dateCreated: date1, imageUrl: "url1", numVotes: 100)
        let picture1_2 = Picture(title: "Pic1", dateCreated: date2, imageUrl: "url1", numVotes: 100)
        let picture1_3 = Picture(title: "Pic1", dateCreated: date1, imageUrl: "url2", numVotes: 100)
        let picture1_4 = Picture(title: "Pic1", dateCreated: date1, imageUrl: "url1", numVotes: 200)
        
        XCTAssertEqual(picture1, picture2)
        XCTAssertNotEqual(picture1, picture1_1)
        XCTAssertNotEqual(picture1, picture1_2)
        XCTAssertNotEqual(picture1, picture1_3)
        XCTAssertNotEqual(picture1, picture1_4)
    }
    
    
}
