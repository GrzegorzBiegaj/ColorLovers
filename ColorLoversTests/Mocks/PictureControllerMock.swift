//
//  PictureControllerMock.swift
//  ColorLoversListTests
//
//  Created by Grzegorz Biegaj on 19.05.18.
//  Copyright © 2018 Grzesiek. All rights reserved.
//

import Foundation
@testable import ColorLovers

class PictureControllerMock: PictureControllerProtocol {

    var numberOfElements: Int
    var pictures: [Picture] = []

    init (numberOfElements: Int = 10) {
        self.numberOfElements = numberOfElements
    }

    func pictures(offset: Int, userName: String, pictureType: PictureType) async throws -> [Picture] {
        return pictures
    }

    func clearCahe() {
        pictures = []
    }

    
}
