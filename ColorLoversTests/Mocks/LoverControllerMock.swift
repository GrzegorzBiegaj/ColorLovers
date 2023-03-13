//
//  LoverControllerMock.swift
//  ColorLoversListTests
//
//  Created by Grzegorz Biegaj on 19.05.18.
//  Copyright © 2018 Grzesiek. All rights reserved.
//

import Foundation
@testable import ColorLovers

class LoverControllerMock: LoverControllerProtocol {

    var numberOfElements = 10
    var lovers: [Lover] = []
    var connection: RequestConnectionProtocol = NetworkingMock()

    func lovers(offset: Int) async throws -> [Lover] {
        return lovers
    }

    func sortLoversByRatingAndName(lovers: [Lover]) -> [Lover] {
        return lovers
    }

    func clearCahe() {
        lovers = []
    }


}
